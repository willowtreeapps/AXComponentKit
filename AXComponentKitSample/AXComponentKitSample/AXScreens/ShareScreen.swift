import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct ShareScreen {
    let messageField: AXComponent = "share-message-field"
    let sendButton: AXComponent = "share-send-button"
    let dismissButton: AXComponent = "share-dismiss-button"
}
