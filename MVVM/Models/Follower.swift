//
//  Follower.swift
//  MVVM
//
//  Created by Kavindu Dissanayake on 2025-01-27.
//

public struct Follower: Identifiable, Codable {
    public let id: Int
    public let login: String
    public let avatar_url: String
}
