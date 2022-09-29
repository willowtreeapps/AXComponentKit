import Foundation

extension Measurement: Sendable {}

public extension Measurement where UnitType == UnitDuration {
    static func milliseconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .milliseconds)
    }

    static func microseconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .microseconds)
    }

    static func seconds(_ duration: Double) -> Self {
        .init(value: duration, unit: .seconds)
    }

    static func minutes(_ duration: Double) -> Self {
        .init(value: duration, unit: .minutes)
    }

    static func hours(_ duration: Double) -> Self {
        .init(value: duration, unit: .hours)
    }

    var timeInterval: TimeInterval {
        converted(to: .seconds).value
    }
}
