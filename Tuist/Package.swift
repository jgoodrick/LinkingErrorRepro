// swift-tools-version: 5.9

import PackageDescription

//#if TUIST
//    import ProjectDescription
//    import ProjectDescriptionHelpers
//
//    let packageSettings = PackageSettings(
//        productTypes: [
//            "ComposableArchitecture": .macro,
//        ]
//    )
//#endif

let package = Package(
    name: "Packages",
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "shared-state-beta"),
    ]
)

