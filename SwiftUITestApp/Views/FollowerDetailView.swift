//
//  FollowerDetailView.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import SwiftUI

struct FollowerDetailView: View {
    let follower: Follower

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: follower.avatar_url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .shadow(radius: 10)

            Text("@\(follower.login)")
                .font(.title)
                .bold()
            
            Text(follower.name ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(follower.node_id)
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Follower Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
