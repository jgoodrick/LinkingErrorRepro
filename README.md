To reproduce, clone the repo, then (using tuist 4.7):

1. tuist install
2. tuist generate
3. select scheme: 'A Production App'
4. note the errors logged to the terminal output:

  The following warnings need attention:
 · Xcframework 'Dependencies.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Target 'Perception' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'CombineSchedulers.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Target 'Perception' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Target 'DependenciesMacros' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Target 'CasePaths' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'CombineSchedulers.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'XCTestDynamicOverlay.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'Dependencies.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'XCTestDynamicOverlay.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'SwiftUINavigationCore.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework '_CollectionsUtilities.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Target 'ComposableArchitecture' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'Clocks.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'IdentifiedCollections.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Target 'CasePaths' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'CustomDump.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework '_CollectionsUtilities.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'SwiftUINavigationCore.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'Clocks.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'CustomDump.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'OrderedCollections.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'OrderedCollections.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'IdentifiedCollections.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Xcframework 'ConcurrencyExtras.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.
 · Xcframework 'ConcurrencyExtras.xcframework' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Target 'ComposableArchitecture' has been linked from target 'Shared Architecture' and target 'Shared Component C', it is a static product so may introduce unwanted side effects.
 · Target 'DependenciesMacros' has been linked from target 'Shared Architecture' and target 'Shared Component D', it is a static product so may introduce unwanted side effects.

5. build and run
6. note the errors logged to the xcode console:


objc[100]: Class _TtC22ComposableArchitecture22CancellablesCollection is implemented in both ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Architecture.framework/Shared_Architecture (0x10502d1c0) and ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Component_C.framework/Shared_Component_C (0x104aacf78). One of the two will be used. Which one is undefined.
objc[100]: Class _TtCV22ComposableArchitecture17ObservableStateIDP33_6D4934305E32703FEF300E5FAAC84ADD7Storage is implemented in both ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Architecture.framework/Shared_Architecture (0x10502d4c0) and ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Component_C.framework/Shared_Component_C (0x104aad3c8). One of the two will be used. Which one is undefined.
objc[100]: Class _TtCV10Perception20_PerceptionRegistrar22ValuePerceptionStorage is implemented in both ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Architecture.framework/Shared_Architecture (0x10502d948) and ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Component_C.framework/Shared_Component_C (0x104aadc38). One of the two will be used. Which one is undefined.
objc[100]: Class _TtCV10Perception20_PerceptionRegistrarP33_0EA3D834D7A1A3B2C0E2034822DB449B6Extent is implemented in both ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Architecture.framework/Shared_Architecture (0x10502d9f0) and ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Component_C.framework/Shared_Component_C (0x104aadce0). One of the two will be used. Which one is undefined.
objc[100]: Class _TtC10PerceptionP33_CCEAA126C9EF747F9CF2C149A205822F18PerceptionChecking is implemented in both ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Architecture.framework/Shared_Architecture (0x10502dab8) and ~/Library/Developer/Xcode/DerivedData/Workspace-gsdgkqwsojvcsqagkkttmbpxupbq/Build/Products/Debug-iphonesimulator/Shared_Component_C.framework/Shared_Component_C (0x104aadda8). One of the two will be used. Which one is undefined.
