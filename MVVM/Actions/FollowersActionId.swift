//
//  FollowersActionId.swift
//  MVVM
//
//  Created by Kavindu Dissanayake on 2025-01-27.
//

// MARK: - Data fetching actions
enum FollowersActions: String, ActionIdType {
    case fetchFollowers
}

// MARK: - UI-only actions (taps, navigation, etc.)
enum FollowersUIActions: UIActionType {
    case tappedFollowersButton
    case tappedFollowersRetryButton
}

/*
 TODO: if we need seperate string for analytics use this
     enum FollowersUIActions: UIActionType {
         case tappedFollowers
         
         var analyticsEventName: String {
             switch self {
             case .tappedFollowers: return "tapped_followers"
             }
         }
     }
 */
