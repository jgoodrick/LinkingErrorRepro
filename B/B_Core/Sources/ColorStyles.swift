
import ComposableArchitecture
import SwiftUI
import Shared_Component_C

@Reducer
struct BVersion {
    @ObservableState
    struct State {
        var component_C: SharedComponent.State = .init(message: "B Message")
    }
    enum Action {
        case component_C(SharedComponent.Action)
    }
}

struct BVersionView: View {
    let store: StoreOf<BVersion>
    var body: some View {
        SharedComponentView(store: store.scope(state: \.component_C, action: \.component_C))
    }
}
