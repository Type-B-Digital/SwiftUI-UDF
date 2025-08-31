//
//  AppConfig.swift
//  WhiteLableing
//
//  Created by KavinduDissanayake on 2025-08-31.
//

import Foundation
import UIKit


final class AppConfig {
    
    enum Key: String {
        case apiKey = "API_KEY"
        case baseURL = "BASE_URL"
        case bundleId = "BUNDLE_ID"
        case appFlavor = "APPFLAVOR"
    }
    
    static func getValueFor( key: Key) -> String? {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: "AppConfig") as? [String: String] else { return nil }
        return dictionary[key.rawValue]
    }
    
    static func getValueForURL(_ key: Key) -> String? {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: "AppConfig") as? [String: String] else { return nil }
        let newUrl = dictionary[key.rawValue]?.replacingOccurrences(of: "\\/", with: "/")
        return newUrl
    }
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    // Device ID
    static var deviceID: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "UnknownDeviceID"
    }
    
    // Device Type/Model
    static var deviceType: String {
        return UIDevice.modelName
    }
    
    // SystemVersion
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    static var appStoreUrl: URL? {
        return URL(string: "https://apps.apple.com/lk/app/clicklife/id###")
    }
    
    static var appStoreAppId: String {
        return "###"
    }
    
    // New function to get the environment type based on the app flavor
    static func getEnvironmentType() -> AppEnvironmentType? {
        guard let flavor = getValueFor(key: .appFlavor) else { return nil }
        return AppEnvironmentType(rawValue: flavor)
    }
    
    // Function to determine if logging should be enabled
    static func shouldEnableLogging() -> Bool {
        return  getEnvironmentType()  != .production
    }
    
    // Temp soltion for for wolrd wild certfication not in development flavor
    static func enableCertficates() -> Bool {
        return  getEnvironmentType() == .production
    }
    
}
