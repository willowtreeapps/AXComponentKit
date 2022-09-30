import Foundation

/// Defines the drag gesture path in relative coordinates
/// for a scroll operation
internal struct ScrollTransaction {
    /// The relative position at the beginning of the drag
    let source: CGVector

    /// The relative position at the end of the drag
    let destination: CGVector

    /// Creates a `ScrollTransaction` along the horizontal axis.
    ///
    /// Allows the gesture to be composed in simpler terms by only requiring
    /// the relative start/end positions along the horizontal axis. Relative
    /// positions are in the domain of `0.0 ... 1.0` from left to right
    /// along the view.
    ///
    /// - Parameters:
    ///   - start:
    ///       The relative starting position along the horizontal axis
    ///   - end:
    ///       The relative ending position along the horizontal axis
    /// - Returns:
    ///       A new `ScrollTransaction`
    static func horizontal(
        from start: CGFloat,
        to end: CGFloat
    ) -> ScrollTransaction {
        .init(from: (x: start, y: 0.5), to: (x: end, y: 0.5))
    }

    /// Creates a `ScrollTransaction` along the vertical axis.
    ///
    /// Allows the gesture to be composed in simpler terms by only requiring
    /// the relative start/end positions along the vertical axis. Relative
    /// positions are in the domain of `0.0 ... 1.0` from top to bottom
    /// along the view.
    ///
    /// - Parameters:
    ///   - start:
    ///       The relative starting position along the vertical axis
    ///   - end:
    ///       The relative ending position along the vertical axis
    /// - Returns:
    ///       A new `ScrollTransaction`
    static func vertical(
        from start: CGFloat,
        to end: CGFloat
    ) -> ScrollTransaction {
        .init(from: (x: 0.5, y: start), to: (x: 0.5, y: end))
    }

    /// Initializes the `ScrollTransaction` with default parameters
    /// that match the given direction.
    ///
    /// - Parameter direction:
    ///       The direction in which the test runner should scroll the view
    init(direction: ScrollDirection) {
        // The starting positions are inset somewhat to
        // try and avoid swiping safe areas. The mechanism
        // could probably account for this better, but it
        // works fine for now.
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

    /// Convenience initializer for expressing a transaction in
    /// slightly more succinct terms. Tuples are slightly more
    /// compact and readable than `.init(dx:dy:)` for creating
    /// `CGVector`s.
    ///
    /// Relative positions are in the domain of `0.0 ... 1.0`
    /// from left to right or top to bottom along the view, for the
    /// x and y axes, respectively.
    ///
    /// - Parameters:
    ///   - start:
    ///       The relative starting position
    ///   - end:
    ///       The relative ending position
    private init(
        from: (x: CGFloat, y: CGFloat),
        to: (x: CGFloat, y: CGFloat)
    ) {
        source = .init(dx: from.x, dy: from.y)
        destination = .init(dx: to.x, dy: to.y)
    }
}
