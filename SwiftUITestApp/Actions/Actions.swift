//
//  Actions.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

/// action with a data fetch request and a data fetch response
enum FetchFollowers: BaseAction {
    case request(name: String)
    case perform(followers: [Follower])
    case success
    case failure(error: APIError)

    func getState() -> ActionStatus {
        switch self {
        case .success: return .COMPLETED
        case .failure: return .ERROR
        default: return .INIT
        }
    }

    func getError() -> APIError? {
        switch self {
        case .failure(let error): return error
        default: return nil
        }
    }
}

/// action without a data fetch
enum SelectFollower: BaseAction {
    case perform(followers: [Follower])
    func getState() -> ActionStatus { .COMPLETED }
    func getError() -> APIError? { nil }
}
