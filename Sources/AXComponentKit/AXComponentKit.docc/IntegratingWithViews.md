# Integrating With Views

How to integrate AXComponentKit with SwiftUI ~and UIKit~

## Overview

In traditional iOS apps, managing accessibility identifiers can be difficult and can lead to a large number of strings to manage. One of the first goals of AXComponentKit was to make a uniform pattern for dealing with these identifiers and approach the concepts of assigning identifiers and retrieving elements _with_ those identifiers in automation tests a comprehensive strategy.

Screen models and navigator extensions are wonderful tools, but the view hierarchy of your application needs to be associated with the components in their relevant screen models for all of the pieces to work together. Fortunately, AXComponentKit makes this just as easy as assigning accessibility identifiers. 

> Note: AXComponentKit was built with SwiftUI in mind, but all of the view modifiers presented in this guide are philosophically compatible with UIKit. More work is required to see the UIKit variants of these view modifiers come to life.

## Screen Identifiers

Screens are an interesting case, so let's get those out of the way up front. In SwiftUI, the lines between "views" and "screens" are a bit more blurry than in UIKit. In SwiftUI, we suggest using your best judgement to figure out what part of your hierarchy embodies a "screen."

_Strictly_ technically speaking, you could tag any view as being "the screen" so long as the view is always present no matter what happens to the contents of that screen. Since that's a complicated disclaimer, we like to think about it as simply "tag the outermost view of your screen."

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
