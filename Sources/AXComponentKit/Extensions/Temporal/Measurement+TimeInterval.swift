import Foundation

extension Measurement: Sendable {}

public extension Measurement where UnitType == UnitDuration {
    /// Creates a `Measurement<UnitDuration>` from a millisecond value
    ///
    /// - Parameter duration: the amount of time, in milliseconds
    /// - Returns: a new duration measurement
    static func milliseconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .milliseconds)
    }

    /// Creates a `Measurement<UnitDuration>` from a microseconds value
    ///
    /// - Parameter duration: the amount of time, in microseconds
    /// - Returns: a new duration measurement
    static func microseconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .microseconds)
    }

    /// Creates a `Measurement<UnitDuration>` from a seconds value
    ///
    /// - Parameter duration: the amount of time, in seconds
    /// - Returns: a new duration measurement
    static func seconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .seconds)
    }

    /// Creates a `Measurement<UnitDuration>` from a minutes value
    ///
    /// - Parameter duration: the amount of time, in minutes
    /// - Returns: a new duration measurement
    static func minutes(_ duration: Double) -> Self {
        .init(value: duration, unit: .minutes)
    }

    /// Creates a `Measurement<UnitDuration>` from an hours value
    ///
    /// - Parameter duration: the amount of time, in hours
    /// - Returns: a new duration measurement
    static func hours(_ duration: Double) -> Self {
        .init(value: duration, unit: .hours)
    }

    /// The duration value, converted to seconds
    var timeInterval: TimeInterval {
        converted(to: .seconds).value
    }
}
