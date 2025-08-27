//
//  FollowersListView.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import SwiftUI

struct FollowersListView: View {
    @StateObject private var viewModel = FollowersViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading followers...")
                } else {
                    Button("Fetch Git Followers") {
                        viewModel.fetchFollowers(name: "KavinduDissanayake")
                    }
                    .buttonStyle(.borderedProminent)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle("Git Followers")
            .navigationDestination(isPresented: $viewModel.navigateToList) {
                FollowersResultView(viewModel: viewModel)
            }
        }
        
    }
}

//#Preview {
//    FollowersListView()
//}
