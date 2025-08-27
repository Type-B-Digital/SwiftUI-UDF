//
//  FollowersResultView.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import SwiftUI

struct FollowersResultView: View {
    @ObservedObject var viewModel: FollowersViewModel

    var body: some View {
        List(viewModel.followers) { follower in
            NavigationLink {
                FollowerDetailView(follower: follower)
            } label: {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: follower.avatar_url)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(follower.login)
                            .font(.headline)
                        Text(follower.name ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(follower.node_id)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Followers")
    }
}
