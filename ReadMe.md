# SwiftUI White-Labeling Template

A powerful and flexible iOS white-labeling solution built with SwiftUI that allows you to create multiple branded versions of your app from a single codebase.

## 🚀 Features

### **Multi-Brand Support**
- **BrandA**: Enterprise solution with production, staging, and development environments
- **BrandB**: Consumer-focused app with multiple deployment configurations
- **BrandC**: Custom branded version with flexible configuration options

### **Environment Management**
- **Development**: Local development and testing
- **Staging**: Pre-production testing and QA
- **Production**: Live production deployment

### **Dynamic Configuration**
- **App Names**: Dynamic branding based on configuration
- **API Keys**: Environment-specific API configurations
- **Base URLs**: Different endpoints for each environment
- **Bundle IDs**: Unique identifiers for each brand/environment
- **App Flavors**: Environment type detection and management

## 📁 Project Structure

```
SwiftUI-UDF/
├── WhiteLableing/                 # Main app source code
│   ├── App/                      # App entry point
│   ├── Views/                    # SwiftUI views
│   ├── Utils/                    # Configuration utilities
│   └── Extensions/               # Swift extensions
├── Resources/                     # Brand-specific resources
│   ├── ConfigurationFiles/       # .xcconfig files
│   │   ├── BrandA/              # BrandA configurations
│   │   ├── BrandB/              # BrandB configurations
│   │   └── BrandC/              # BrandC configurations
│   ├── Assets/                   # Brand-specific assets
│   ├── Fonts/                    # Custom fonts
│   └── Localization/             # Multi-language support
└── WhiteLableing.xcodeproj/      # Xcode project file
```

## ⚙️ Configuration Files

### **BrandA Configuration Example**
```xcconfig
// BrandA_Dev.xcconfig
API_KEY = sk-dev-brandA-development-key
BASE_URL = https://dev-api.brandA.com/v1
BUNDLE_ID = com.brandA.app.dev
APP_FLAVOR = development
APP_NAME = BrandA Dev
```

### **BrandB Configuration Example**
```xcconfig
// BrandB_Dev.xcconfig
API_KEY = sk-dev-brandB-development-key
BASE_URL = https://dev-api.brandB.com/v1
BUNDLE_ID = com.brandB.app.dev
APP_FLAVOR = development
APP_NAME = BrandB Dev
```

## 🔧 Usage

### **1. Building Different Brands**
```bash
# Build BrandA Development
xcodebuild -project WhiteLableing.xcodeproj -scheme BrandA -configuration Dev build

# Build BrandB Staging
xcodebuild -project WhiteLableing.xcodeproj -scheme BrandB -configuration Stag build

# Build BrandC Production
xcodebuild -project WhiteLableing.xcodeproj -scheme BrandC -configuration Prod build
```

### **2. Running on Simulator**
```bash
# Install BrandB app
xcrun simctl install booted /path/to/BrandB.app

# Launch BrandB app
xcrun simctl launch booted com.sample.WhiteLableing
```

### **3. Code Example - Dynamic App Name**
```swift
// In your SwiftUI view
Text(AppConfig.getValueFor(key: .appName) ?? "Default Brand")
    .font(.largeTitle)
    .fontWeight(.bold)
```

### **4. Environment Detection**
```swift
// Check if logging should be enabled
if AppConfig.shouldEnableLogging() {
    // Enable debug logging
}

// Check if certificates should be enabled
if AppConfig.enableCertficates() {
    // Enable production certificates
}
```

## 🎯 Key Benefits

1. **Single Codebase**: Maintain one codebase for multiple brands
2. **Easy Branding**: Change colors, logos, and names via configuration
3. **Environment Isolation**: Separate development, staging, and production
4. **Scalable**: Add new brands without code changes
5. **Maintainable**: Centralized configuration management
6. **CI/CD Friendly**: Easy automation for different environments

## 🛠️ Technical Implementation

### **Configuration Management**
- Uses Xcode's `.xcconfig` files for environment-specific settings
- `AppConfig.swift` provides type-safe access to configuration values
- Supports multiple configuration keys: `API_KEY`, `BASE_URL`, `BUNDLE_ID`, `APP_FLAVOR`, `APP_NAME`

### **Build System**
- Xcode schemes for each brand
- File system synchronization for automatic file inclusion
- Environment-specific build configurations

### **SwiftUI Integration**
- Dynamic UI based on configuration values
- Brand-specific theming and styling
- Responsive design that adapts to different configurations

## 🔄 Workflow

1. **Select Brand**: Choose target brand (BrandA, BrandB, BrandC)
2. **Select Environment**: Choose environment (Dev, Stag, Prod)
3. **Build**: Xcode compiles with appropriate configuration
4. **Deploy**: Install and run on target device/simulator
5. **Verify**: App displays correct branding and configuration

## 📱 Supported Platforms

- **iOS**: 15.0+
- **Xcode**: 14.0+
- **Swift**: 5.7+
- **SwiftUI**: 3.0+

## 🚦 Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd SwiftUI-UDF
   ```

2. **Open in Xcode**
   ```bash
   open WhiteLableing.xcodeproj
   ```

3. **Select your target brand and environment**

4. **Build and run**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with multiple brands/environments
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the configuration examples
- Review the build logs for errors

---

**Happy White-Labeling! 🎨✨**
