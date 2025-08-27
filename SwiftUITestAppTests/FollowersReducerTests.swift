//
//  FollowersReducerTests.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import Quick
import Nimble
@testable import SwiftUITestApp

class FollowersReducerTests: QuickSpec {
     func spec() {
        FollowersReducerTests.describe("FollowersReducer") {
            FollowersReducerTests.it("sets followers on FetchFollowers.success action") {
                // Arrange
                let followers = [
                    Follower(id: 1, login: "user1", avatar_url: "", name: "User One", node_id: ""),
                    Follower(id: 2, login: "user2", avatar_url: "", name: "User Two", node_id: "")
                ]
                let initialState = AppState().followersState

                // Act
                let newState = followersReducer(
                    action: FetchFollowers.success(followers: followers),
                    state: initialState
                )

                // Assert
                expect(newState.followers.count).to(equal(2))
                expect(newState.followers[0].login).to(equal("user1"))
            }
        }
    }
}
