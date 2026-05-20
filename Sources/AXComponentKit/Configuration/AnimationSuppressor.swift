#if canImport(UIKit)
import UIKit

@MainActor
final class AnimationSuppressor {
    static let shared = AnimationSuppressor()
    private var isActivated = false

    func activate() {
        guard !isActivated else { return }
        isActivated = true
        UIView.setAnimationsEnabled(false)
        NotificationCenter.default.addObserver(
            forName: UIWindow.didBecomeVisibleNotification,
            object: nil,
            queue: .main
        ) { notification in
            guard let window = notification.object as? UIWindow else { return }
            window.layer.speed = 100
        }
    }
}
#endif
