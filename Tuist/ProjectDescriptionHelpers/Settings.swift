
import ProjectDescription

public extension Dictionary<String, Plist.Value> {
    static func displayName(_ name: Plist.Value) -> Self {
        ["CFBundleDisplayName": name]
    }
    func orientations(all: DeviceOrientations = [], iPad: DeviceOrientations = [], iPhone: DeviceOrientations = []) -> Self {
        var copy = self
        if !all.isEmpty {
            copy["UISupportedInterfaceOrientations"] = all.plistValue
        }
        if !iPad.isEmpty {
            copy["UISupportedInterfaceOrientations_iPad"] = iPad.plistValue
        }
        if !iPhone.isEmpty {
            copy["UISupportedInterfaceOrientations_iPhone"] = iPad.plistValue
        }
        return copy
    }
    func requiresFullScreen() -> Self {
        var copy = self
        copy["UIRequiresFullScreen"] = "YES"
        return copy
    }
}

public extension SettingsDictionary {
    static func moduleVerifier() -> Self {
        [
            "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS": "gnu11 gnu++14",
            "ENABLE_MODULE_VERIFIER": "YES",
        ]
    }
    static func userScriptSandboxing() -> Self {
        [
            "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
        ]
    }
    static func generateAssetSymbolExtensions() -> Self {
        [
            "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "YES",
        ]
    }
    static func exportingAnXCFrameworkForDistribution() -> Self {
        [
            "SKIP_INSTALL": "NO",
            "BUILD_LIBRARY_FOR_DISTRIBUTION": "YES",
            "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
            "ENABLE_PREVIEWS": "YES",
        ]
    }
}

public extension Settings {
    func version(_ version: Version) -> Self {
        var copy = self
        copy.base["MARKETING_VERSION"] = .string("\(version.major).\(version.minor).\(version.patch)")
        return copy
    }
    func build(_ value: SettingValue) -> Self {
        var copy = self
        copy.base["CURRENT_PROJECT_VERSION"] = value
        return copy
    }
    func apply(_ additionalBuildSettings: SettingsDictionary) -> Self {
        var copy = self
        additionalBuildSettings.forEach { (key, value) in
            copy.base[key] = value
        }
        return copy
    }
}


public typealias DeviceOrientations = Set<DeviceOrientation>

public extension DeviceOrientations {
    static let all: Self = [.portrait, .portraitUpsideDown, .landscapeLeft, .landscapeRight]
    static let vertical: Self = [.portrait, .portraitUpsideDown]
    static let landscape: Self = [.landscapeLeft, .landscapeRight]
    static let portrait: Self = [.portrait]
    static let portraitUpsideDown: Self = [.portraitUpsideDown]
    static let landscapeLeft: Self = [.landscapeLeft]
    static let landscapeRight: Self = [.landscapeRight]
    internal var plistValue: Plist.Value {
        .string(self.map(\.rawValue).sorted().joined(separator: " "))
    }
}

public enum DeviceOrientation: String {
    case portrait = "UIInterfaceOrientationPortrait"
    case portraitUpsideDown = "UIInterfaceOrientationPortraitUpsideDown"
    case landscapeLeft = "UIInterfaceOrientationLandscapeLeft"
    case landscapeRight = "UIInterfaceOrientationLandscapeRight"
}


