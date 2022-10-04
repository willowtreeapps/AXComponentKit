# Philosophy

The design considerations behind AXComponentKit


## Overview

AXComponentKit is a thin, lightweight framework that simplifies the setup and execution of UI automation tests. It was inspired by the desire to reduce complexity of UI testing code through patterns that feel more natural in Swift and do not involve heavily abstracting XCTest. Special emphasis was given to propagating more informative failure diagnostics than typically provided by traditional XCTest abstractions.

#### Identity

AXComponentKit follows a Page Object Model (POM) structure, but since iOS doesn't have "pages," refers to them as **screen models**. These models are shared between both the app and test targets to create a single source of truth.  They store **components**, which function as automation identifiers and can be either static or dynamically computed based on their context within a screen. 

Screen models opt-in to capabilities via protocol composition, allowing their functionality to be precisely defined. For example, a screen model may opt into a protocol that gives it access to a shared tab bar element, or navigation bars. This compositional approach is in contrast to POM architectures that rely on inheritance to propagate elements and behaviors such that parent classes often pass down capabilities that individual screens may or may not have. 

#### Navigation

XCTest does not provide much in the way of scaffolding for navigating complex view hierarchies. This can lead to complex, hard to read, and sometimes unreliable abstractions being hastily written to help with different test cases as needs arise. AXComponentKit attempts to solve this problem by providing scaffolding to make navigation easier to reason about, and much more stable.

Each screen model has an associated **Navigator**, which breaks up navigation into discrete operations driven by actions on the UI. A successful operation returns a navigator for its destination screen, making operations _composable_ into a chain.  This means operations can be used and reused within chains to traverse multiple screens.

#### Safety

Historically, a common source of flaky UI automation tests is attempting to interact with elements that are not yet visible. This can be due to sluggish animated transitions in a continuous integration pipeline, or even due to simulator size variations. One of AXComponentKit's primary goals is to significantly reduce flakiness by providing guarantees about XCUIElement readiness for interaction. 

Structured concurrency provides a natural means of accessing UI elements asynchronously in UI tests. Fetching an element inherently ensures its existence, unless the test author explicitly fetches it without the guarantee. This notion is carried forward to ensure the existence of entire screens during navigation, which provides a new failure diagnostic that is much easier to understand. If an element is queried and does not come into existence within a timeout period, an error is thrown and the test fails with another informative diagnostic.


