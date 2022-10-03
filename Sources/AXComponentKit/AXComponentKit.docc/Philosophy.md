# Philosophy

The design considerations behind AXComponentKit

## Overview
AXComponentKit is a thin, lightweight framework designed to simplify the complex nature of writing UI tests.  Unlike other frameworks, which build abstractions around XCTest, AXComponentKit abstracts app code itself, providing a structured pattern for accessing elements and navigating the app within UI tests.

### Identity
Identifiers are stored in screen models that are members of both the app and the test targets.  They can be either static or dynamically computed based on their context within the app.  Screen models opt-in to capabilities via protocol composition so that their properties and capabilities are only present where relevant.

### Navigation
A screen model's navigator breaks up navigation into atomic units starting on itself, the source screen, and ending on a specified destination screen. The composable nature of these units allows smaller navigation events from one screen to the next to be chained and composed into larger navigation events that span multiple screens.

### Safety
The syntax of async await is leveraged to make a readable and safe method to access elements and navigate throughout the app in UI tests. 

