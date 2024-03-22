
import ComposableArchitecture
import SwiftUI
import Shared_Layouts

@Reducer
public struct ComponentC {
    @ObservableState
    public struct State {
        public init(message: String) {
            self.message = message
        }
        
        public var message: String = "Hello World"
    }
    public enum Action {
        case tappedButton
    }
}

public struct ComponentCView: View {
    public init(store: StoreOf<ComponentC>) {
        self.store = store
    }
    
    let store: StoreOf<ComponentC>
    
    public var body: some View {
        VStack {
            Spacer()
            SharedButton(
                action: { store.send(.tappedButton) },
                model: .init(message: store.message)
            )
        }
    }
}
