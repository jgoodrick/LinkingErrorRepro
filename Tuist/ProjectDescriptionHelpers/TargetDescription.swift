
import ProjectDescription

public protocol UnderscoredID {
    var underscored: String { get }
}

public protocol TargetDescription: UnderscoredID {
    var isTestTarget: Bool { get }
    var sources: SourceFilesList? { get }
    var resources: ResourceFileElements? { get }
    var entitlements: Entitlements? { get }
    var dependencies: [TargetDependency] { get }
    var targetName: String { get }
    var destinations: Destinations { get }
    var product: Product { get }
    var productName: String? { get }
    var bundleId: String { get }
    var deploymentTargets: DeploymentTargets { get }
    var infoPlist: InfoPlist? { get }
    var copyFiles: [CopyFilesAction]? { get }
    var headers: Headers? { get }
    var scripts: [TargetScript] { get }
    var settings: Settings { get }
    var coreDataModels: [CoreDataModel]  { get }
    var environmentVariables: [String : EnvironmentVariable] { get }
    var launchArguments: [LaunchArgument] { get }
    var additionalFiles: [FileElement] { get }
    var buildRules: [BuildRule] { get }
    var mergedBinaryType: MergedBinaryType { get }
    var mergeable: Bool { get }
}

public extension UnderscoredID {
    var spaced: String { underscored.replacingOccurrences(of: "_", with: " ") }
    var dotted: String { underscored.replacingOccurrences(of: "_", with: ".") }
    var rawComponents: [String] { underscored.components(separatedBy: "_") }
    var allButLastComponent: String { rawComponents.dropLast().joined(separator: "_") }
    var targetName: String { spaced }
}

public extension TargetDescription {

    var target: Target {
        switch self {
        default:
            Target.target(
                name: targetName,
                destinations: destinations,
                product: product,
                productName: productName,
                bundleId: bundleId,
                deploymentTargets: deploymentTargets,
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                copyFiles: copyFiles,
                headers: headers,
                entitlements: entitlements,
                scripts: scripts,
                dependencies: dependencies,
                settings: settings,
                coreDataModels: coreDataModels,
                environmentVariables: environmentVariables,
                launchArguments: launchArguments,
                additionalFiles: additionalFiles,
                buildRules: buildRules,
                mergedBinaryType: mergedBinaryType,
                mergeable: mergeable
            )
        }
    }

    var destinations: Destinations { .iOS }
    var product: Product {
        if isTestTarget {
            .unitTests
        } else {
            .framework
        }
    }
    var productName: String? { underscored }
    var bundleId: String { "com.minimal.repro.\(dotted)" }
    var deploymentTargets: DeploymentTargets { .iOS("16.0") }
    var entitlements: Entitlements? { .none }
    var resources: ResourceFileElements? { .none }
    var infoPlist: InfoPlist? { .default }
    var copyFiles: [CopyFilesAction]? { .none }
    var headers: Headers? { .none }
    var scripts: [TargetScript] { [] }
    var settings: Settings {
        Settings.settings()
            .apply(.moduleVerifier())
            .apply(.userScriptSandboxing())
    }
    var coreDataModels: [CoreDataModel]  { [] }
    var environmentVariables: [String : EnvironmentVariable] { [:] }
    var launchArguments: [LaunchArgument] { [] }
    var additionalFiles: [FileElement] { [] }
    var buildRules: [BuildRule] { [] }
    var mergedBinaryType: MergedBinaryType { .disabled }
    var mergeable: Bool { false }
    
}
