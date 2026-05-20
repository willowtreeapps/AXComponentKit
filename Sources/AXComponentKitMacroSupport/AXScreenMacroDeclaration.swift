import AXComponentKit

@attached(member, names: named(screenIdentifier))
@attached(extension, conformances: AXScreen)
public macro AXScreen() = #externalMacro(module: "AXComponentKitMacros", type: "AXScreenMacro")

@attached(member, names: named(screenIdentifier))
@attached(extension, conformances: AXScreen)
public macro AXScreen(identifier: String) = #externalMacro(module: "AXComponentKitMacros", type: "AXScreenMacro")
