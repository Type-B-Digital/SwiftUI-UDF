//
//  FollowersViewModel.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import Foundation
import ReSwift
import Combine

class FollowersViewModel: BaseViewModel {
    @Published var followers: [Follower] = []
    @Published var navigateToList: Bool = false
    @Published var errorMessage: String?

    func fetchFollowers(name :String) {
        errorMessage = nil
        followers = []
        navigateToList = false
        dispatchAction(FetchFollowers.request(name: name))
    }

    override func onStateUpdate(state: AppState, action: BaseAction?) -> Bool {
        guard let action = action else { return false }

        switch action {
        case is FetchFollowers:
            self.followers = state.followers.followers
            self.navigateToList = true
            return true
        default:
            return false
        }
    }
    
    override func onError(error: APIError?, action: BaseAction?) {
        guard let action = action else { return }
        
            switch action {
            case is FetchFollowers:
                self.errorMessage = error?.localizedDescription
            default:
                break
            }
    }
}
