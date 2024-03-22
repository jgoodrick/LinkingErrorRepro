
import ComposableArchitecture
import SwiftUI

@main
struct BProductionApp: App {
    
    let store: StoreOf<BProductionApplication> = .init(
        initialState: .init(),
        reducer: { BProductionApplication() }
    )
    
    var body: some Scene {
        WindowGroup {
            BProductionApplicationView(store: store)
        }
    }
}

@Reducer
struct BProductionApplication {}

struct BProductionApplicationView: View {
    let store: StoreOf<BProductionApplication>
    var body: some View {
        Text("A Production Application")
    }
}
