//
//  GitHubService.swift
//  MVVM
//
//  Created by Kavindu Dissanayake on 2025-01-27.
//

import Foundation

struct NetworkService: NetworkServiceProtocol {
    func fetchFollowers(username: String) async throws -> [Follower] {
        guard let url = URL(string: "https://api.github.com/users/\(username)/followers") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Follower].self, from: data)
    }
}

public protocol NetworkServiceProtocol {
    func fetchFollowers(username: String) async throws -> [Follower]
}
