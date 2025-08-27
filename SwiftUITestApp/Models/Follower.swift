//
//  Follower.swift
//  SwiftUITestApp
//
//  Created by Kavindu Dissanayake on 2025-08-27.
//

import Foundation

struct Follower: Codable, Identifiable, Equatable {
    let id: Int
    let login: String
    let avatar_url: String
    let name: String?
    let node_id:String
}
