
import Foundation

public struct SharedModel {
    public init(message: String = "Shared Model Message") {
        self.message = message
    }
    
    public var message: String = "Shared Model Message"
}
