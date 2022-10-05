# Setting Up Screen Models

How to add screen models to your project

## Overview

The Screen Model is a container for components that exist within "a screen full" of content. This would usually be something like a tab within your tab bar, or a single level within a navigation stack. Most of the examples for this guide reference code directly from the `AXComponentKitSample` app, which is bundled in the package repo.

## Creating a Model

Screen models in `AXComponentKit` rely heavily on protocols. For something to be "a screen," the only requirement is that it conforms to ``AXScreen``. Additional protocols can (and should!) be created as part of your test target that allow your screen to adopt additional capabilities. More on that _here_ (link).

Here is how we define the initial screen in our sample app, without any of its components, and without satisfying the requirements of ``AXScreen``:
```swift
struct FirstTabScreen: AXScreen {
    // TODO: Fulfill protocol requirements
}
```
> Note: ``AXScreen`` requires an `init()` initializer, which is synthesized by the compiler automatically if all properties have an initial default value. All screen models in the sample project rely on the compiler to provide this initializer.

### Screen Identifiers

From a test automation perspective, being able to ask the question "what screen is currently visible?" instead of simply "what elements are currently visible?" is quite useful. It provides clearer guarantees about the state of the app under test, and allows more descriptive diagnostic errors to surface when an expected screen doesn't show up.

To facilitate this, every screen model must provide a `screenIdentifier` that should uniquely identify that screen. As of now, these are static identifiers and there is not a mechanism for dynamic variation in the spirit of ``AXComponent``.

Fulfilling this requirement for our example screen looks something like this:
```swift
struct FirstTabScreen: AXScreen {
    static let screenIdentifier = "first-tab-screen"
}
```
> Note: There is currently no mechanism to ensure that all screens are identified uniquely, so choose a naming scheme that can scale over time!

## Defining Components

A screen on its own is not very useful without components! Fortunately, they are easy to add. There are a few types of components to choose from for different use cases, so we'll cover them one by one.


### Static Components

The most common component is ``AXComponent``, which allows a static identifier to be specified for a view in your app. ``AXComponent`` should be used in situations where you have an element on screen that does not get reused and does not change its identity at any point during the screen's lifecycle. For example, the countdown timer label in a timer app.

Here is the recommended syntax for defining a button component on the example screen from above. This button is fixed in the middle of the screen and does not change:

```swift
struct FirstTabScreen: AXScreen {
    static let screenIdentifier = "first-tab-screen"

    let detailButton: AXComponent = "first-tab-screen-detail-button"
}
```
All component types take advantage of the `ExpressibleByStringLiteral` protocol, so they can be defined inline with this concise syntax. 


### Dynamic Components

Static components don't work well for situations where identifiers should really reflect the dynamic nature of the content they're associated with. For these situations, ``AXDynamicComponent`` provides a straightforward means to dynamically construct identifiers at runtime, but in a type-safe way.

A dynamic component uses the string literal provided at its declaration as a prefix for its identifier. The dynamic value is later stringified and concatenated. An example of the result is below.

Here's an example from our sample app of a dynamic component from the Second Tab screen:
```swift
struct SecondTabScreen: AXScreen {
    static let screenIdentifier = "second-tab-screen"

    let rowItem: AXDynamicComponent<Int> = "second-tab-dynamic-row"
}
```

As you can see, `AXDynamicComponent<Value>` is generic and allows the consumer to specify what `Value` actually is. This means that dynamic components can take any type of data you want to provide them.

In this example, the component takes an `Int` because the identifier is derived from the index its row in the list, making each row unique in the eyes of the test runner. Generated identifiers for `rowItem` look like this at runtime:
```
second-tab-dynamic-row-0
second-tab-dynamic-row-1
second-tab-dynamic-row-2
```

#### Default Types

By default, ``AXDynamicComponent`` has support for Swift's signed and unsigned integer types, as well as strings. `AXComponentKit` can add support for more native types over time, but these cover most of the common use cases.

#### Custom Types

``AXDynamicComponent`` can also support identifiers that are generated based on custom types not natively supported by `AXComponentKit`. Custom types that conform to the ``AXDynamicValue`` protocol can work just as effortlessly as the default types listed above.

Here is an example of a custom type being defined and used in a contrived example:

```swift
enum Animal: String {
    case lion
    case tiger
    case bear
}

extension Animal: AXDynamicValue {
    var automationDynamicValue: String { 
        self.rawValue
    }
}

struct ZooScreen: AXScreen {
    static let screenIdentifier = "this-screen-is-a-zoo"

    let animalRow: AXDynamicComponent<Animal> = "second-tab-animal-row"
}
```

Generated identifiers for `animalRow` would look like this at runtime:
```
second-tab-animal-row-lion
second-tab-animal-row-tiger
second-tab-animal-row-bear
```

### Scroll Views

Scroll views are a special case to enhance test reliability. When interacting with scrolling content, test runners often have to make assumptions about which scroll view they are interacting with, and where it exists on screen. Furthermore, querying for different kinds of scroll views in a generic way can be cumbersome because `XCUIElementQuery` does not consider table and collection views to be "scroll views."

To address this, `AXComponentKit` prefers explicit declaration of scroll views to ensure the intended view is being scrolled while running tests. An example of this can be seen on the second tab screen:
```
struct SecondTabScreen: AXScreen {
    static let screenIdentifier = "second-tab-screen"

    let table: AXScrollView = "second-table-table-view"
}
```

`AXScrollView` is used to designate a container and for aiding in scrolling. Scroll views cannot be directly queried like other components from the test runner.

### Shared Components

In many iOS Page Object Model architectures, it is common to have a `BaseScreen` class that all screen models inherit from. This provides a convenient way for shared identifiers to proliferate to all screens, but it can easily become a dumping ground for accessibility identifiers that are not _actually_ accessible on all screens all the time.

To combat this, we recommend approaching shared elements through protocol composition. One can define a "Capability" that a screen model can adopt:
```swift
// Declare a protocol for the new capability
protocol BottomToolbarNavigable { }

// Add default components in a protocol extension
extension BottomToolbarNavigable {

    // Protocol extensions must not store any state, so
    // anything added must be a computed property
    var toolbarButtonLeading: AXComponent { 
        "bottom-toolbar-button-leading" 
    }
}

// Add this capability to one or more screens
extension FirstScreen: BottomToolbarNavigable { }
extension SecondScreen: BottomToolbarNavigable { }
extension ThirdScreen: BottomToolbarNavigable { }
```

If you find yourself with many screens that share the same capabilities, consider making a single protocol that unifies them:

```swift
// Define a protocol that encompasses an overall flow
protocol ToolbarFlowScreen: AXScreen, BottomToolbarNavigable { }

// Adopt that protocol in your screens instead of AXScreen
struct FirstScreen: ToolbarFlowScreen { 
    ...
}

struct SecondScreen: ToolbarFlowScreen { 
    ...
}

struct ThirdScreen: ToolbarFlowScreen { 
    ...
}
```

### System Components

The system UI frameworks do not always provide an API for assigning accessibility identifiers to views. For example, tab bars handle their own accessibility configuration and do not allow specific identifiers to be associated with tab bar items.

In order for these elements to work seamlessly in a unified API with `AXComponentKit`, we recommend treating these as capabilities (see above). For capabilities that provide access to system elements such as a tab bar, it should be preferred to build upon AXComponentKit primitives (or contribute new ones to AXComponentKit if not already present). For the tab bar example, see `AXTabBarNavigable` and `AXTabComponent` in `AXComponentKitTestSupport`. Together, these allow our sample app's test target to declare `RootTabBarNavigable`:

```swift
protocol RootTabBarNavigable: AXTabBarNavigable {}

extension RootTabBarNavigable {
    var first: AXTabComponent<FirstTabScreen> {
        .init(name: "First")
    }

    var second: AXTabComponent<SecondTabScreen> {
        .init(name: "Second")
    }
}
```
`AXTabBarNavigable` provides a means to handle special-case navigation to these components, while `AXTabComponent` provides a means of defining what a tab component is and what destination screen that tab contains. This makes the actual lift of adding a system capability to your application code base much lower than it otherwise would've been. 
