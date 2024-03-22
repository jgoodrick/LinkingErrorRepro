
import SwiftUI
import Shared_Models

public struct SharedButton: View {
    public init(action: @escaping () -> Void, model: SharedModel) {
        self.action = action
        self.model = model
    }
    
    let action: () -> Void
    let model: SharedModel
    
    public var body: some View {
        Button(action: action, label: { Text(model.message) })
    }
}
