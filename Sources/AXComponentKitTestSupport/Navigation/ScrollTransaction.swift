import Foundation

struct ScrollTransaction {
    let source: CGVector
    let destination: CGVector

    static func horizontal(
        from start: CGFloat,
        to end: CGFloat
    ) -> ScrollTransaction {
        .init(from: (x: start, y: 0.5), to: (x: end, y: 0.5))
    }

    static func vertical(
        from start: CGFloat,
        to end: CGFloat
    ) -> ScrollTransaction {
        .init(from: (x: 0.5, y: start), to: (x: 0.5, y: end))
    }

    init(direction: ScrollDirection) {
        switch direction {
        case .up:
            self = .vertical(from: 0.25, to: 1.0)
        case .down:
            self = .vertical(from: 0.9, to: 0.0)
        case .left:
            self = .horizontal(from: 0.25, to: 1.0)
        case .right:
            self = .horizontal(from: 0.9, to: 0.0)
        }
    }

    private init(
        from: (x: CGFloat, y: CGFloat),
        to: (x: CGFloat, y: CGFloat)
    ) {
        source = .init(dx: from.x, dy: from.y)
        destination = .init(dx: to.x, dy: to.y)
    }
}
