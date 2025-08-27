//
//  FollowersMiddleware.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import ReSwift

let followersMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in

            if let tracked = action as? TrackedAction,
               let inner = tracked.innerAction as? FetchFollowers {

                switch inner {
                case .request(let username):
                    
                    ///this section can be our existing NetworkUtil fetch functions
                    APIService.shared.fetchFollowers(for: username) { result in
                        switch result {
                        case .success(let followers):
                            
                            /// Dispatching perform action with fetched followers
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.perform(followers: followers)
                            ))
                            
                            /// Dispatching success action after performing the fetch
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.success
                            ))
                            
                        case .failure(let error):
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.failure(error: error)
                            ))
                        }
                    }

                default: break
                }
            }

            /// Always forward the action to next middleware/reducer
            next(action)
        }
    }
}
