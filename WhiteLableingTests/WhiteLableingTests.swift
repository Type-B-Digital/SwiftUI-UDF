//
//  WhiteLableingTests.swift
//  WhiteLableingTests
//
//  Created by KavinduDissanayake on 2025-08-31.
//

import Testing
import Foundation

struct WhiteLableingTests {

    @Test func testAppConfigValues() async throws {
        // Test that AppConfig can read values
        let appName = AppConfig.getValueFor(key: .appName)
        let apiKey = AppConfig.getValueFor(key: .apiKey)
        let baseUrl = AppConfig.getValueFor(key: .baseUrl)
        let bundleId = AppConfig.getValueFor(key: .bundleId)
        let appFlavor = AppConfig.getValueFor(key: .appFlavor)
        
        // Verify values are not nil
        #expect(appName != nil, "App name should not be nil")
        #expect(apiKey != nil, "API key should not be nil")
        #expect(baseUrl != nil, "Base URL should not be nil")
        #expect(bundleId != nil, "Bundle ID should not be nil")
        #expect(appFlavor != nil, "App flavor should not be nil")
        
        // Verify values are not empty
        #expect(!appName!.isEmpty, "App name should not be empty")
        #expect(!apiKey!.isEmpty, "API key should not be empty")
        #expect(!baseUrl!.isEmpty, "Base URL should not be empty")
        #expect(!bundleId!.isEmpty, "Bundle ID should not be empty")
        #expect(!appFlavor!.isEmpty, "App flavor should not be empty")
    }
    
    @Test func testAppEnvironmentType() async throws {
        // Test environment type detection
        let environmentType = AppConfig.getEnvironmentType()
        #expect(environmentType != nil, "Environment type should not be nil")
        
        // Test environment-specific functions
        let shouldLog = AppConfig.shouldEnableLogging()
        let shouldCert = AppConfig.enableCertficates()
        
        // These should return boolean values
        #expect(shouldLog == true || shouldLog == false, "Should enable logging should return boolean")
        #expect(shouldCert == true || shouldCert == false, "Should enable certificates should return boolean")
    }
    
    @Test func testDeviceInfo() async throws {
        // Test device information
        let deviceId = AppConfig.deviceID
        let deviceType = AppConfig.deviceType
        let systemVersion = AppConfig.systemVersion
        
        #expect(!deviceId.isEmpty, "Device ID should not be empty")
        #expect(!deviceType.isEmpty, "Device type should not be empty")
        #expect(!systemVersion.isEmpty, "System version should not be empty")
    }
    
    @Test func testAppConfigKeys() async throws {
        // Test all AppConfig keys
        let keys: [AppConfig.Key] = [.appName, .apiKey, .baseUrl, .bundleId, .appFlavor, .appIcon, .splashScreen]
        
        for key in keys {
            let value = AppConfig.getValueFor(key: key)
            #expect(value != nil, "Value for key \(key) should not be nil")
        }
    }

}
