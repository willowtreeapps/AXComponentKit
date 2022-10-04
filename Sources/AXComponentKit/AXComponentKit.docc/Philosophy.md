# Philosophy

The design considerations behind AXComponentKit

## Overview
AXComponentKit is a thin, lightweight framework that simplifies the setup and execution of UI automation tests. XCComponentKit was created with the opinion that tests can be succinct and digestible if we shift our thinking from writing convenience abstractions around XCTest and instead focus on reducing the complexity of testing our application code. 

This model provides a pattern that gives more informative failure diagnostics, while creating more readable code that uses modern Swift language features. 

#### Identity
Identifiers are stored in screen models that are members of both the app and the test targets.  They can be either static or dynamically computed based on their context within the app.  Screen models opt-in to capabilities via protocol composition so that their properties and capabilities are only present where relevant.

#### Navigation
A screen model's navigator breaks up navigation into atomic units starting on itself, the source screen, and ending on a specified destination screen. The composable nature of these units allows smaller navigation events from one screen to the next to be chained and composed into larger navigation events that span multiple screens.

#### Safety
The syntax of async await is leveraged to make a readable and safe method to access elements and navigate throughout the app in UI tests. 

