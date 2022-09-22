import AXComponentKit
import Foundation

public struct AXTabComponent<Content> where Content: AXScreenModel {
    let name: String
    let index: UInt

    public init(index: UInt, name: String) {
        self.name = name
        self.index = index
    }
}
