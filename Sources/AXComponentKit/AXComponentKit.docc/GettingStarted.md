# Getting Started with AXComponentKit

Integrating AXComponentKit in your project

## Overview

### 

> Tip: AXComponentKit setup requires paying careful attention to the target when adding new files, as it is not possible to link against XCTest or anything that imports XCTest when building the app target.

- Setting up screen models
    - Screen Identifiers
    - Defining Components
        - Static
        - Dynamic
        - ScrollViews
        - Capability-related components
            - TabBar
            - NavBar
    - Wiring-up components/assigning identifiers
        - Static
            - SwiftUI
            - UIKit (optional)
        - Dynamic
            - SwiftUI
            - UIKit (optional)
        - ScrollViews
            - SwiftUI
            - UIKit (optional)
        - Capability-related components
            - No assigning identifiers in either framework.  Write hooks for the navigator because the system behaves as it does. Clear example for TabBar
- Setting up navigators
    - Concrete example
    - Maybe a picture
- Writing your first UITest
    - Accessing elements
        - Default behavior vs assumed 
        - Static vs dynamic
        - Scrolling
    - Navigation operations
    * Explain everything in the context of a test

