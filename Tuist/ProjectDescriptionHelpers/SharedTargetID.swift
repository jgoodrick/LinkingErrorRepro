
import ProjectDescription

public enum SharedTargetID: String, CaseIterable {
    case Shared_Component_C
    case Shared_Component_D
    case Shared_Architecture
    case Shared_Layouts
    case Shared_Models
}

extension SharedTargetID: UnderscoredID {
    public var underscored: String { rawValue }
}

extension TargetDependency {
    public static func shared(_ id: SharedTargetID) -> Self {
        .project(target: id.targetName, path: .relativeToRoot("Shared"), condition: .none)
    }
}

extension TargetDescription {
    public var shared_Core: Array<TargetDependency> {
        [
            .shared(.Shared_Component_C),
            .shared(.Shared_Layouts),
            .shared(.Shared_Models),
        ]
    }

}
