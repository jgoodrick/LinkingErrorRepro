
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
    }
}

public struct ACoreFeatureView: View {
    public init(store: StoreOf<ACoreFeature>) {
        self.store = store
    }
    
    let store: StoreOf<ACoreFeature>
    public var body: some View {
        Text(store.message)
    }
}
