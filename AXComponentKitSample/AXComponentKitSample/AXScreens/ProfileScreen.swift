import AXComponentKit
import AXComponentKitMacroSupport

@AXScreen
struct ProfileScreen {
    let profileField: AXDynamicComponent<String> = "profile-field"
    let saveButton: AXComponent = "profile-save-button"
    let closeButton: AXComponent = "profile-close-button"
}
