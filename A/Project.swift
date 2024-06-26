
import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = Project.init(
    name: "A",
    targets: TargetID.allCases.map(\.target)
)

enum TargetID: String, CaseIterable {
    case A_Production_App
    case A_Production_App_Tests
    case A_Core
    case A_Core_Tests
    case A_Kit
    case A_Kit_Example_App
    case A_Kit_Tests
}

extension TargetID {
    var dependencies: [TargetDependency] {
        switch self {
        case .A_Production_App:
            return [
                .shared(.Shared_Component_C),
                .shared(.Shared_Layouts),
                .shared(.Shared_Models),

                .target(name: TargetID.A_Core.targetName, condition: .none)
            ]
        case .A_Production_App_Tests:
            return [
                .target(name: TargetID.A_Production_App.targetName, condition: .none)
            ]
        case .A_Core:
            return [
                .shared(.Shared_Component_C),
                .shared(.Shared_Layouts),
                .shared(.Shared_Models),
            ]
        case .A_Core_Tests:
            return [
                .target(name: TargetID.A_Core.targetName, condition: .none)
            ]
        case .A_Kit:
            return [
                .shared(.Shared_Component_C),
                .shared(.Shared_Layouts),
                .shared(.Shared_Models),

                .target(name: TargetID.A_Core.targetName, condition: .none)
            ]
        case .A_Kit_Example_App:
            return [
                .target(name: TargetID.A_Kit.targetName, condition: .none)
            ]
        case .A_Kit_Tests:
            return [
                .target(name: TargetID.A_Kit.targetName, condition: .none)
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
        case .A_Production_App, .A_Kit_Example_App:
            .app
        case .A_Production_App_Tests, .A_Kit_Tests, .A_Core_Tests:
            .unitTests
        case .A_Core, .A_Kit:
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
        case .A_Production_App:
            "\(underscored)/Config/\(underscored).entitlements"
        default:
            .none
        }
    }

    var resources: ResourceFileElements? {
        switch self {
        case .A_Production_App, .A_Kit_Example_App:
            "\(underscored)/Resources/**"
        default:
            .none
        }
    }
    
    var infoPlist: InfoPlist? {
        switch self {
        case .A_Production_App:
            InfoPlist.extendingDefault(
                with:
                    .displayName(.string("A Production App"))
                    .requiresFullScreen()
                    .orientations(
                        all: .portrait,
                        iPhone: .portrait
                    )
            )
        case .A_Kit_Example_App:
            InfoPlist.extendingDefault(
                with:
                    .displayName(.string("A Kit"))
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
        case .A_Production_App:
            Settings.settings()
                .version(.init(1, 0, 0))
                .build(.string("1"))
        case .A_Kit:
            Settings.settings(
                release: .exportingAnXCFrameworkForDistribution()
            )
            .version(.init(1, 0, 0))
            .build(.string("1"))
        case .A_Kit_Example_App:
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

