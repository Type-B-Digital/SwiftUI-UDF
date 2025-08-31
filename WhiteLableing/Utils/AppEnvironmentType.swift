//
//  AppEnvironmentType.swift
//  WhiteLableing
//
//  Created by KavinduDissanayake on 2025-08-31.
//

import SwiftUI

enum AppEnvironmentType: String, CaseIterable {
    case development = "development"
    case staging = "staging"
    case production = "production"
    
    var displayName: String {
        switch self {
        case .development:
            return "Development"
        case .staging:
            return "Staging"
        case .production:
            return "Production"
        }
    }
    
    var color: Color {
        switch self {
        case .development:
            return .blue
        case .staging:
            return .orange
        case .production:
            return .green
        }
    }
}
