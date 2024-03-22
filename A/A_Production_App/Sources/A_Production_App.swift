
import A_Core
import ComposableArchitecture
import SwiftUI

@main
struct AProductionApp: App {
    
    let store: StoreOf<AProductionApplication> = .init(
        initialState: .init(),
        reducer: { AProductionApplication() }
    )
    
    var body: some Scene {
        WindowGroup {
            AProductionApplicationView(store: store)
        }
    }
}

@Reducer
struct AProductionApplication {
    @ObservableState 
    struct State {
        var core_feature: ACoreFeature.State = .init()
    }
    enum Action {
        case aCoreFeature(ACoreFeature.Action)
    }
}

struct AProductionApplicationView: View {
    let store: StoreOf<AProductionApplication>
    var body: some View {
        VStack {
            Text("A Production Application")
            ACoreFeatureView(store: store.scope(state: \.core_feature, action: \.aCoreFeature))
        }
    }
}
