//
//  AppReducer.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

func followersReducer(action: BaseAction, state: FollowersState) -> FollowersState {
    var state = state
    
    switch action {
    case FetchFollowers.perform(let followers):
        state.followers = followers
    default:
        break
    }
    return state
}
