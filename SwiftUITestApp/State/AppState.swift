//
//  AppState.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

struct AppState {
    var followers: FollowersState = FollowersState()
    
    /// this dictionary tracks the current status of actions by their ID
    var systemStateUpdateTracker: [String: BaseAction] = [:]
}


/// you can use this selector to get all followers from the state from anywhere in the app
let getAllFollowers = { (state: AppState) -> [Follower] in
    return state.followers.followers
}
