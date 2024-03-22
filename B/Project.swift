
import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = Project.init(
    name: "B",
    targets: TargetID.allCases.map(\.target)
)

enum TargetID: String, CaseIterable {
    case B_Production_App
    case B_Production_App_Tests
    case B_Core
    case B_Core_Tests
    case B_Kit
    case B_Kit_Example_App
    case B_Kit_Tests
}

extension TargetID {
    var dependencies: [TargetDependency] {
        switch self {
        case .B_Production_App: 
            return shared_Core + [
                .target(name: TargetID.B_Core.targetName, condition: .none)
            ]
        case .B_Production_App_Tests: 
            return [
                .target(name: TargetID.B_Production_App.targetName, condition: .none)
            ]
        case .B_Core: 
            return shared_Core
        case .B_Core_Tests: 
            return [
                .target(name: TargetID.B_Core.targetName, condition: .none)
            ]
        case .B_Kit:
            return shared_Core + [
                .target(name: TargetID.B_Core.targetName, condition: .none)
            ]
        case .B_Kit_Example_App: 
            return [
                .target(name: TargetID.B_Kit.targetName, condition: .none)
            ]
        case .B_Kit_Tests:
            return [
                .target(name: TargetID.B_Kit.targetName, condition: .none)
            ]
        }
    }
}

// MARK: - Parsing
extension TargetID {
    var underscored: String { rawValue }
    var isTestTarget: Bool { .Tests == components.last }
    var groupsSourceFilesSeparately: Bool {
        components.last == .App || components.last == .Kit
    }
    var bundlesResources: Bool {
        components.last == .App
    }
    var usesEntitlementsFile: Bool {
        components.last == .App
    }
    var components: [MatchableComponent] { rawComponents.compactMap(MatchableComponent.init(rawValue:)) }
    var associatedTestTargetID: TargetID? {
        guard isTestTarget else { return nil }
        return .init(rawValue: rawComponents.filter({ $0 != MatchableComponent.Tests.rawValue }).joined(separator: "_"))
    }
    enum MatchableComponent: String {
        case App, Kit, Core, Tests
    }
}

extension TargetID: TargetDescription {
    
    var deploymentTargets: DeploymentTargets {
        .iOS("17.0")
    }
    
    var sources: SourceFilesList? {
        if !isTestTarget {
            "\(underscored)/Sources/**"
        } else {
            "\(allButLastComponent)/Tests/**"
        }
    }
    
    var product: Product {
        switch self {
        case .B_Production_App, .B_Kit_Example_App:
            .app
        case .B_Production_App_Tests, .B_Kit_Tests, .B_Core_Tests:
            .unitTests
        case .B_Core, .B_Kit:
            .framework
        }
    }
    
    var bundleId: String {
        switch self {
        default:
            "com.minimal.repro.\(dotted)"
        }
    }
    
    var entitlements: Entitlements? {
        switch self {
        case .B_Production_App:
            "\(underscored)/Config/\(underscored).entitlements"
        default:
            .none
        }
    }

    var resources: ResourceFileElements? {
        switch self {
        case .B_Production_App, .B_Kit_Example_App:
            "\(underscored)/Resources/**"
        default:
            .none
        }
    }
    
    var infoPlist: InfoPlist? {
        switch self {
        case .B_Production_App:
            InfoPlist.extendingDefault(
                with:
                    .displayName(.string("B Production App"))
                    .requiresFullScreen()
                    .orientations(
                        all: .portrait,
                        iPhone: .portrait
                    )
            )
        case .B_Kit_Example_App:
            InfoPlist.extendingDefault(
                with:
                    .displayName(.string("B Kit"))
                    .requiresFullScreen()
                    .orientations(
                        all: .portrait,
                        iPhone: .portrait
                    )
            )
        default:
            InfoPlist.default
        }
    }
            
    var settings: Settings {
        switch self {
        case .B_Production_App:
            Settings.settings()
                .version(.init(1, 0, 0))
                .build(.string("1"))
        case .B_Kit:
            Settings.settings(
                release: .exportingAnXCFrameworkForDistribution()
            )
            .version(.init(1, 0, 0))
            .build(.string("1"))
        case .B_Kit_Example_App:
            Settings.settings()
                .version(.init(1, 0, 0))
                .build(.string("1"))
        default:
            Settings.settings()
                .apply(.moduleVerifier())
                .apply(.userScriptSandboxing())
        }
    }
        
}

