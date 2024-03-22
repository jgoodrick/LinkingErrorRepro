
import Shared_Component_C
import ComposableArchitecture
import SwiftUI

@Reducer
public struct ACoreFeature {
    public init() {}
    
    @ObservableState
    public struct State {
        public init(message: String = "A Core Feature") {
            self.message = message
        }
        
        var message: String = "A Core Feature"
        var component: ComponentC.State = .init(message: "injected message")
    }
    
    public enum Action {
        case component(ComponentC.Action)
    }
}

public struct ACoreFeatureView: View {
    public init(store: StoreOf<ACoreFeature>) {
        self.store = store
    }
    
    let store: StoreOf<ACoreFeature>
    public var body: some View {
        VStack {
            Text(store.message)
            ComponentCView(store: store.scope(state: \.component, action: \.component))
        }
        .background(Color.gray)
    }
}
