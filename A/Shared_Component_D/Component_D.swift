
import ComposableArchitecture
import SwiftUI
import Shared_Layouts

@Reducer
public struct ComponentD {
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

public struct ComponentDView: View {
    public init(store: StoreOf<ComponentD>) {
        self.store = store
    }
    
    let store: StoreOf<ComponentD>
    
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
