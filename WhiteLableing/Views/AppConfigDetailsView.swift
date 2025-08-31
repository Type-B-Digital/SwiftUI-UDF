//
//  ContentView.swift
//  WhiteLableing
//
//  Created by KavinduDissanayake on 2025-08-31.
//

import SwiftUI

struct AppConfigDetailsView: View {
    @State private var refreshTrigger = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header with app info
                    AppHeaderView()
                    
                    // Environment Info
                    EnvironmentSection()
                    
                    // Configuration Section
                    ConfigurationSection()
                    
                    // Device Information
                    DeviceInfoSection()
                    
                    // App Store Info
                    AppStoreSection()
                    
                    // Settings & Features
                    SettingsSection()
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("App Configuration")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        refreshTrigger.toggle()
                    }
                }
            }
        }
    }
}

struct AppHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "app.badge")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Brand!")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 16) {
                if let version = AppConfig.appVersion {
                    Label("v\(version)", systemImage: "tag")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                
                if let build = AppConfig.appBuild {
                    Label("Build \(build)", systemImage: "hammer")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(12)
    }
}

struct EnvironmentSection: View {
    var body: some View {
        SectionContainer(title: "Environment", icon: "cloud") {
            VStack(spacing: 12) {
                if let environment = AppConfig.getEnvironmentType() {
                    HStack {
                        Circle()
                            .fill(environment.color)
                            .frame(width: 12, height: 12)
                        Text(environment.displayName)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(environment.rawValue)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                } else {
                    Text("Environment not configured")
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                HStack {
                    Text("Logging Enabled")
                    Spacer()
                    Image(systemName: AppConfig.shouldEnableLogging() ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(AppConfig.shouldEnableLogging() ? .green : .red)
                }
                
                HStack {
                    Text("Certificates Enabled")
                    Spacer()
                    Image(systemName: AppConfig.enableCertficates() ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(AppConfig.enableCertficates() ? .green : .red)
                }
            }
        }
    }
}

struct ConfigurationSection: View {
    var body: some View {
        SectionContainer(title: "Configuration", icon: "gear") {
            VStack(spacing: 12) {
                ConfigRow(title: "API Key", value: AppConfig.getValueFor(key: .apiKey), isSecret: true)
                ConfigRow(title: "Base URL", value: AppConfig.getValueForURL(.baseURL))
                ConfigRow(title: "Bundle ID", value: AppConfig.getValueFor(key: .bundleId))
                ConfigRow(title: "App Flavor", value: AppConfig.getValueFor(key: .appFlavor))
            }
        }
    }
}

struct DeviceInfoSection: View {
    var body: some View {
        SectionContainer(title: "Device Information", icon: "iphone") {
            VStack(spacing: 12) {
                InfoRow(title: "Device ID", value: AppConfig.deviceID, icon: "fingerprint")
                InfoRow(title: "Device Model", value: AppConfig.deviceType, icon: "iphone")
                InfoRow(title: "iOS Version", value: AppConfig.systemVersion, icon: "gear.badge")
            }
        }
    }
}

struct AppStoreSection: View {
    var body: some View {
        SectionContainer(title: "App Store", icon: "bag") {
            VStack(spacing: 12) {
                InfoRow(title: "App ID", value: AppConfig.appStoreAppId, icon: "number")
                
                if let appStoreUrl = AppConfig.appStoreUrl {
                    HStack {
                        Label("App Store URL", systemImage: "link")
                            .foregroundColor(.primary)
                        Spacer()
                        Link("Open", destination: appStoreUrl)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct SettingsSection: View {
    var body: some View {
        SectionContainer(title: "Settings & Features", icon: "slider.horizontal.3") {
            VStack(spacing: 12) {
                FeatureRow(
                    title: "Debug Logging",
                    description: "Enables detailed logging for debugging",
                    isEnabled: AppConfig.shouldEnableLogging()
                )
                
                FeatureRow(
                    title: "SSL Certificates",
                    description: "Validates SSL certificates in network requests",
                    isEnabled: AppConfig.enableCertficates()
                )
            }
        }
    }
}

struct SectionContainer<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct ConfigRow: View {
    let title: String
    let value: String?
    let isSecret: Bool
    
    init(title: String, value: String?, isSecret: Bool = false) {
        self.title = title
        self.value = value
        self.isSecret = isSecret
    }
    
    @State private var showSecret = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            HStack {
                if let value = value {
                    if isSecret && !showSecret {
                        Text("•••••••")
                            .foregroundColor(.secondary)
                            .font(.system(.body, design: .monospaced))
                        Button {
                            showSecret.toggle()
                        } label: {
                            Image(systemName: "eye")
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text(value)
                            .foregroundColor(.secondary)
                            .font(.system(.caption, design: .monospaced))
                            .lineLimit(1)
                            .truncationMode(.middle)
                        if isSecret {
                            Button {
                                showSecret.toggle()
                            } label: {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                } else {
                    Text("Not configured")
                        .foregroundColor(.red)
                        .italic()
                }
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .font(.system(.caption, design: .monospaced))
        }
    }
}

struct FeatureRow: View {
    let title: String
    let description: String
    let isEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .fontWeight(.medium)
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: isEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isEnabled ? .green : .red)
                    .font(.title2)
            }
        }
    }
}

// Sample usage view
struct AppConfigSampleView: View {
    var body: some View {
        TabView {
            AppConfigDetailsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Config")
                }
            
            // Additional tab for quick debug info
            DebugQuickView()
                .tabItem {
                    Image(systemName: "ladybug")
                    Text("Debug")
                }
        }
    }
}

struct DebugQuickView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Quick Info") {
                    HStack {
                        Text("Environment")
                        Spacer()
                        if let env = AppConfig.getEnvironmentType() {
                            Text(env.rawValue)
                                .fontWeight(.medium)
                        } else {
                            Text("Unknown")
                                .foregroundColor(.red)
                        }
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("\(AppConfig.appVersion ?? "Unknown") (\(AppConfig.appBuild ?? "Unknown"))")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Device")
                        Spacer()
                        Text(AppConfig.deviceType)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Status") {
                    HStack {
                        Image(systemName: "doc.text")
                        Text("Logging")
                        Spacer()
                        Text(AppConfig.shouldEnableLogging() ? "Enabled" : "Disabled")
                            .foregroundColor(AppConfig.shouldEnableLogging() ? .green : .red)
                    }
                    
                    HStack {
                        Image(systemName: "lock.shield")
                        Text("Certificates")
                        Spacer()
                        Text(AppConfig.enableCertficates() ? "Enabled" : "Disabled")
                            .foregroundColor(AppConfig.enableCertficates() ? .green : .red)
                    }
                }
                
                Section("Actions") {
                    if let appStoreUrl = AppConfig.appStoreUrl {
                        Link(destination: appStoreUrl) {
                            HStack {
                                Image(systemName: "bag")
                                Text("Open in App Store")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                    .font(.caption)
                            }
                        }
                    }
                    
                    Button {
                        // Copy device ID to clipboard
                        UIPasteboard.general.string = AppConfig.deviceID
                    } label: {
                        HStack {
                            Image(systemName: "doc.on.doc")
                            Text("Copy Device ID")
                            Spacer()
                        }
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Debug Info")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


#Preview{
    AppConfigDetailsView()
}
