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
                    /// Async/await version
                    Task {
                        do {
                            let followers = try await APIService.shared.fetchFollowers(for: username)
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.perform(followers: followers)
                            ))
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.success
                            ))
                        } catch let error as APIError {
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.failure(error: error)
                            ))
                        } catch {
                            dispatch(TrackedAction(
                                actionId: tracked.actionId,
                                innerAction: FetchFollowers.failure(error: .networkError(error))
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
