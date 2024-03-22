
import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = Project.init(
    name: "Shared",
    targets: SharedTargetID.allCases.map(\.target)
)

extension SharedTargetID: TargetDescription {
    
    public var isTestTarget: Bool {
        false
    }
    
    public var folderPath: String {
        if !isTestTarget {
            "Sources/\(underscored)"
        } else {
            "Tests/\(underscored)"
        }
    }

    public var sources: SourceFilesList? {
        "\(folderPath)/**"
    }

}

// MARK: - Dependencies

extension SharedTargetID {

    public var dependencies: [TargetDependency] {
        switch self {
            
            // Shared Core
        case .Shared_Component_C:
            return [
                .target(name: SharedTargetID.Shared_Architecture.targetName, condition: .none),
                .target(name: SharedTargetID.Shared_Layouts.targetName, condition: .none),
                .target(name: SharedTargetID.Shared_Models.targetName, condition: .none),
            ]
        case .Shared_Component_D:
            return [
                .target(name: SharedTargetID.Shared_Architecture.targetName, condition: .none),
                .target(name: SharedTargetID.Shared_Layouts.targetName, condition: .none),
                .target(name: SharedTargetID.Shared_Models.targetName, condition: .none),
            ]
        case .Shared_Architecture:
            return [
                .external(name: "ComposableArchitecture", condition: .none),
            ]
        case .Shared_Layouts:
            return [
                .target(name: SharedTargetID.Shared_Models.targetName, condition: .none),
            ]
        case .Shared_Models:
            return [
            ]
        }
    }
}
