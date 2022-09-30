import Foundation

/// Defines a generic means of making any type not
/// supported by default into a value compatible with
/// `AXDynamicComponent`
///
/// Here's an example where `UUID` is being extended
/// to support `AXDynamicValue`:
/// ```
/// extension UUID: AXDynamicValue {
///     var automationDynamicValue: String {
///         uuidString
///     }
/// }
/// ```
public protocol AXDynamicValue {
    /// A unique value that can be used to identify a corresponding
    /// `AXComponent` at runtime
    var automationDynamicValue: String { get }
}
