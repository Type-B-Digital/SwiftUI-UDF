//
//  ContentView.swift
//  WhiteLableing
//
//  Created by KavinduDissanayake on 2025-08-31.
//

import SwiftUI

// MARK: - Main Tab View
struct MainTabView: View {
    @State private var selectedTab = 0
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab - App Configuration
            HomeConfigView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Settings Tab
            AppSettingsView(isDarkMode: $isDarkMode)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(1)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .tint(.blue)
    }
}

// MARK: - Home Configuration View
struct HomeConfigView: View {
    @State private var refreshTrigger = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Hero Section
                    AppHeroSection()
                    
                    // Quick Stats Cards
                    QuickStatsSection()
                    
                    // Configuration Overview
                    ConfigurationOverviewSection()
                    
                    // Environment & Status
                    EnvironmentStatusSection()
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("App Overview")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        refreshTrigger.toggle()
                        // Add haptic feedback
                        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                        impactFeedback.impactOccurred()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
            .refreshable {
                refreshTrigger.toggle()
            }
        }
    }
}

// MARK: - App Settings View
struct AppSettingsView: View {
    @Binding var isDarkMode: Bool
    @State private var notificationsEnabled = true
    @State private var analyticsEnabled = false
    @State private var autoUpdateEnabled = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    // Appearance Section
                    AppearanceSection(isDarkMode: $isDarkMode)
                    
                    // App Preferences
                    PreferencesSection(
                        notificationsEnabled: $notificationsEnabled,
                        analyticsEnabled: $analyticsEnabled,
                        autoUpdateEnabled: $autoUpdateEnabled
                    )
                    
                    // About Section
                    AboutSection()
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Hero Section
struct AppHeroSection: View {
    var body: some View {
        VStack(spacing: 16) {
            // App Icon with gradient background
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "app.badge")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 8) {
                Text(AppConfig.getValueFor(key: .appName) ?? "Brand!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                
                if let version = AppConfig.appVersion, let build = AppConfig.appBuild {
                    Text("Version \(version) • Build \(build)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ), lineWidth: 1)
                )
        )
    }
}

// MARK: - Quick Stats Section
struct QuickStatsSection: View {
    var body: some View {
        HStack(spacing: 12) {
            StatCard(
                title: "Environment",
                value: AppConfig.getEnvironmentType()?.displayName ?? "Unknown",
                icon: "cloud.fill",
                color: AppConfig.getEnvironmentType()?.color ?? .gray
            )
            
            StatCard(
                title: "Status",
                value: "Active",
                icon: "checkmark.circle.fill",
                color: .green
            )
            
            StatCard(
                title: "Device",
                value: AppConfig.deviceType,
                icon: "iphone",
                color: .orange
            )
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(color)
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

// MARK: - Configuration Overview Section
struct ConfigurationOverviewSection: View {
    var body: some View {
        ModernSectionContainer(title: "Configuration Overview", icon: "gear", color: .blue) {
            VStack(spacing: 16) {
                ModernConfigRow(
                    title: "API Endpoint",
                    value: AppConfig.getValueForURL(.baseURL) ?? "Not configured",
                    icon: "link",
                    color: .blue
                )
                
                ModernConfigRow(
                    title: "Bundle Identifier",
                    value: AppConfig.getValueFor(key: .bundleId) ?? "Unknown",
                    icon: "app.badge",
                    color: .green
                )
                
                ModernConfigRow(
                    title: "App Flavor",
                    value: AppConfig.getValueFor(key: .appFlavor) ?? "Default",
                    icon: "star.fill",
                    color: .orange
                )
                
                ModernConfigRow(
                    title: "Device ID",
                    value: AppConfig.deviceID,
                    icon: "fingerprint",
                    color: .purple,
                    isCopyable: true
                )
            }
        }
    }
}

// MARK: - Environment Status Section
struct EnvironmentStatusSection: View {
    var body: some View {
        ModernSectionContainer(title: "System Status", icon: "dot.radiowaves.left.and.right", color: .green) {
            VStack(spacing: 16) {
                StatusRow(
                    title: "System Version",
                    description: "iOS \(AppConfig.systemVersion)",
                    isEnabled: true,
                    icon: "gear.badge"
                )
            }
        }
    }
}

// MARK: - Appearance Section
struct AppearanceSection: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        ModernSectionContainer(title: "Appearance", icon: "paintbrush.fill", color: .purple) {
            VStack(spacing: 20) {
                // Theme Toggle
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Dark Mode")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("Switch between light and dark themes")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $isDarkMode)
                        .toggleStyle(CustomToggleStyle())
                }
                
                // Theme Preview Cards
                HStack(spacing: 16) {
                    ThemePreviewCard(title: "Light", isSelected: !isDarkMode, isDark: false) {
                        isDarkMode = false
                    }
                    
                    ThemePreviewCard(title: "Dark", isSelected: isDarkMode, isDark: true) {
                        isDarkMode = true
                    }
                }
            }
        }
    }
}

struct ThemePreviewCard: View {
    let title: String
    let isSelected: Bool
    let isDark: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isDark ? Color.black : Color.white)
                    .frame(height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isDark ? Color.white.opacity(0.2) : Color.black.opacity(0.1), lineWidth: 1)
                    )
                    .overlay(
                        HStack {
                            Circle()
                                .fill(isDark ? Color.white : Color.black)
                                .frame(width: 4, height: 4)
                            Rectangle()
                                .fill(isDark ? Color.white.opacity(0.6) : Color.black.opacity(0.6))
                                .frame(width: 12, height: 2)
                            Spacer()
                        }
                        .padding(.horizontal, 6)
                    )
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .blue : .secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

// MARK: - Preferences Section
struct PreferencesSection: View {
    @Binding var notificationsEnabled: Bool
    @Binding var analyticsEnabled: Bool
    @Binding var autoUpdateEnabled: Bool
    
    var body: some View {
        ModernSectionContainer(title: "App Preferences", icon: "slider.horizontal.3", color: .orange) {
            VStack(spacing: 20) {
                PreferenceRow(
                    title: "Push Notifications",
                    description: "Receive important app updates",
                    icon: "bell.fill",
                    isEnabled: $notificationsEnabled,
                    color: .red
                )
                
                PreferenceRow(
                    title: "Analytics",
                    description: "Help improve app performance",
                    icon: "chart.bar.fill",
                    isEnabled: $analyticsEnabled,
                    color: .blue
                )
                
                PreferenceRow(
                    title: "Auto Updates",
                    description: "Automatically download app updates",
                    icon: "arrow.triangle.2.circlepath",
                    isEnabled: $autoUpdateEnabled,
                    color: .green
                )
            }
        }
    }
}

struct PreferenceRow: View {
    let title: String
    let description: String
    let icon: String
    @Binding var isEnabled: Bool
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .toggleStyle(CustomToggleStyle())
        }
    }
}

// MARK: - About Section
struct AboutSection: View {
    var body: some View {
        ModernSectionContainer(title: "About", icon: "info.circle.fill", color: .indigo) {
            VStack(spacing: 16) {
                if let appStoreUrl = AppConfig.appStoreUrl {
                    Link(destination: appStoreUrl) {
                        HStack {
                            Image(systemName: "bag.fill")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("View in App Store")
                                    .fontWeight(.semibold)
                                Text("Rate and review the app")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                    .foregroundColor(.primary)
                }
                
                Button(action: {
                    UIPasteboard.general.string = AppConfig.deviceID
                    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                    impactFeedback.impactOccurred()
                }) {
                    HStack {
                        Image(systemName: "doc.on.doc.fill")
                            .foregroundColor(.green)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Copy Device ID")
                                .fontWeight(.semibold)
                            Text("Copy to clipboard for support")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
                .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Modern Section Container
struct ModernSectionContainer<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    let content: Content
    
    init(title: String, icon: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            content
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Modern Config Row
struct ModernConfigRow: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let isCopyable: Bool
    
    init(title: String, value: String, icon: String, color: Color, isCopyable: Bool = false) {
        self.title = title
        self.value = value
        self.icon = icon
        self.color = color
        self.isCopyable = isCopyable
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(value)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            if isCopyable {
                Button(action: {
                    UIPasteboard.general.string = value
                    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                    impactFeedback.impactOccurred()
                }) {
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                }
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Status Row
struct StatusRow: View {
    let title: String
    let description: String
    let isEnabled: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(isEnabled ? .green : .red)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(isEnabled ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Image(systemName: isEnabled ? "checkmark" : "xmark")
                    .foregroundColor(isEnabled ? .green : .red)
                    .font(.system(size: 12, weight: .bold))
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Custom Toggle Style
struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 50, height: 30)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 26, height: 26)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            }
            .onTapGesture {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
                configuration.isOn.toggle()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}

#Preview("Home Only") {
    HomeConfigView()
}

#Preview("Settings Only") {
    AppSettingsView(isDarkMode: .constant(false))
}
