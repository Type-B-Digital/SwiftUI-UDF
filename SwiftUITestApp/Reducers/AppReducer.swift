//
//  AppReducer.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

///register your reducer here
func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    if let tracked = action as? TrackedAction {
        state.systemStateUpdateTracker[tracked.actionId] = tracked.innerAction
        state.followers = followersReducer(action: tracked.innerAction, state: state.followers)
    }
    else if let remove = action as? RemoveStateStatus, case .perform(let id) = remove {
        state.systemStateUpdateTracker.removeValue(forKey: id)
    }
    
    return state
}
