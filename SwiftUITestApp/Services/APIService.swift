//
//  APIService.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import Alamofire
import Foundation

enum APIError: Error, LocalizedError {
    case networkError(Error)
    case invalidResponse
    case decodingError

    var errorDescription: String? {
        switch self {
        case .networkError(let underlying):
            return underlying.localizedDescription
        case .invalidResponse:
            return "Invalid server response. Please try again."
        case .decodingError:
            return "Failed to read server data. Please update or try again."
        }
    }
}

class APIService {
    
    static let shared = APIService()
    private init() {}

    ///this section can be our existing NetworkUtil fetch functions
    func fetchFollowers(for user: String, completion: @escaping (Result<[Follower], APIError>) -> Void) {
        let url = "https://api.github.com/users/\(user)/followers"
        
        AF.request(url).responseDecodable(of: [Follower].self) { response in
            switch response.result {
            case .success(let followers):
                completion(.success(followers))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
        .cURLDescription { description in
            print(description)
        }
    }

    /// Async/await variant
    func fetchFollowers(for user: String) async throws -> [Follower] {
        let url = "https://api.github.com/users/\(user)/followers"
        do {
            let followers = try await AF.request(url)
                .serializingDecodable([Follower].self)
                .value
            return followers
        } catch {
            throw APIError.networkError(error)
        }
    }
}
