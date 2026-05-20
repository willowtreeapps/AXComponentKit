# Integrating With Views

How to integrate AXComponentKit with SwiftUI ~and UIKit~

## Overview

Screen models and navigator extensions are wonderful tools, but the view hierarchy of your application needs to be associated with the components in their relevant screen models for all of the pieces to work together. Fortunately, AXComponentKit makes this just as easy as assigning accessibility identifiers. 

> Note: AXComponentKit was built with SwiftUI in mind, but all of the view modifiers presented in this guide are philosophically compatible with UIKit. More work is required to see the UIKit variants of these view modifiers come to life.

## Screen Identifiers

Screens are an interesting case, so let's get those out of the way up front. In SwiftUI, the lines between "views" and "screens" are a bit more blurry than in UIKit. In SwiftUI, we suggest using your best judgement to figure out what part of your hierarchy embodies a "screen." We recommend thinking about this as simply "tag the outermost view/container of your screen."

Here is a gently-modified example from the sample app illustrating how to assign a screen identifier:

```swift
struct FirstTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Button("Push Detail") {
                    // TODO: Something exciting
                }
                .automationComponent(\FirstTabScreen.detailButton)
            }
            .automationScreen(FirstTabScreen.self)
        }
    }
}
```
>Note: The screen is assigned _inside_ the NavigationStack, since each view on the stack constitutes a screen full of content.

The implementation of this works nicely in SwiftUI: AXComponentKit adds a transparent background to your view and assigns the ``AXScreen/screenIdentifier`` as its accessibility identifier. That transparent background is treated as an accessibility container to prevent compatibility issues with VoiceOver.


## Component Identities

The approach for assigning components to views is consistent no matter what type of component you need to assign. Examples of each type are listed below.

#### Static Components

In this modified example from the sample project, this button is being assigned as the detailButton of the FirstTabScreen.

```swift
struct FirstTabView: View {
    var body: some View {
        VStack {
            Button("Push Detail") {
                // TODO: Something exciting
            }
            .automationComponent(\FirstTabScreen.detailButton)
        }
    }
}
```

#### Dynamic Components

In this modified example from the sample project, each row is uniquely identified by an integer and assigned as a row item for the SecondTabScreen. The mechanism is the same as for static components, but an additional dynamic value is required.

```swift
struct SecondTabView: View {

    let items = 1 ... 1000

    var body: some View {
        List(items, id: \.self) { item in
            Text("Item \(item)")
                .automationComponent(\SecondTabScreen.rowItem, value: item)
        }
    }
}
```

#### Optional Dynamic Values

When a dynamic value may be `nil` — for example, during a loading or placeholder state — use the optional-value overload. When the value is `nil`, no accessibility identifier is applied and the element is invisible to automation queries:

```swift
struct SecondTabView: View {

    let items: [Item]   // Item.id may be nil during loading

    var body: some View {
        List(items) { item in
            Text(item.title)
                .automationComponent(\SecondTabScreen.rowItem, value: item.id)
        }
    }
}
```

#### Prefixed Dynamic Components

To distinguish elements that share a component definition but represent a different semantic state, supply a custom prefix. The identifier becomes `"{prefix}-{componentPrefix}_{value}"`:

```swift
Text(item.title)
    .automationComponent(\SecondTabScreen.rowItem, value: item.index, prefix: "featured")
// identifier: "featured-second-tab-dynamic-row_3"
```

#### Scrollview Components

Adding an additional line to the example from above, we can declare the scroll view that houses all row elements.

```swift
struct SecondTabView: View {

    let items = 1 ... 1000

    var body: some View {
        List(items, id: \.self) { item in
            Text("Item \(item)")
                .automationComponent(\SecondTabScreen.rowItem, value: item)
        }
        .automationScrollView(\SecondTabScreen.table)
    }
}
```

## Animation Suppression

UI tests are significantly more reliable when animations are disabled. AXComponentKit provides first-class support for this that activates only when the automation runner is present — it is a no-op in production builds.

### SwiftUI Apps

Apply the `.automationOptimized()` modifier at your app's root view. It disables SwiftUI transaction animations and calls into `AnimationSuppressor` to handle UIKit and Core Animation layers as well.

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .automationOptimized()
        }
    }
}
```

### UIKit and Hybrid Apps

For apps with a UIKit `AppDelegate` (or a hybrid UIKit+SwiftUI app where the root window is managed by UIKit), call `AXAutomation.suppressAnimationsIfNeeded()` from `application(_:didFinishLaunchingWithOptions:)`:

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    Task { @MainActor in
        AXAutomation.suppressAnimationsIfNeeded()
    }
    return true
}
```

> Note: `suppressAnimationsIfNeeded()` is `@MainActor`-isolated. Call it from a `Task { @MainActor in … }` block if your launch method is not already on the main actor. It disables `UIView` animations globally and sets `CALayer.speed = 100` on every new window as it becomes visible, which collapses Core Animation durations to near-zero.
