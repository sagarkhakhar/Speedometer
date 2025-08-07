/*
 * CONTENT VIEW - APP'S MAIN CONTENT WRAPPER
 * =========================================
 * 
 * This file acts like a "container" or "wrapper" for our main speedometer screen.
 * Think of it as a picture frame that holds our speedometer.
 * 
 * WHAT THIS FILE DOES:
 * - Provides a simple way to show our speedometer
 * - Acts as a bridge between the app and our main speedometer view
 * - Can be used for testing and previewing our speedometer
 * 
 * WHY WE HAVE THIS:
 * - It's a standard SwiftUI pattern (like a template)
 * - Makes it easy to test our speedometer in isolation
 * - Provides a clean separation between app setup and actual content
 * 
 * TECHNICAL DETAILS:
 * - View: This is a SwiftUI protocol for creating user interface elements
 * - body: This defines what the view looks like
 * - SpeedometerView(): This is our actual speedometer
 * - #Preview: This lets us see our view in Xcode's preview window
 */

//
//  ContentView.swift
//  Speedometer
//
//  Created by Sagar Khakhar on 06/08/25.
//

import SwiftUI

/// Main content view that wraps our speedometer
/// This is like a picture frame that holds our speedometer display
struct ContentView: View {
    /// This defines what our content view looks like
    /// It simply shows our speedometer - nothing fancy, just the speedometer itself
    var body: some View {
        // SpeedometerView() is our actual speedometer with all the dials and needles
        // This is what users will interact with
        SpeedometerView()
    }
}

/// This creates a preview of our ContentView in Xcode
/// It's like taking a screenshot of our app for testing
/// When you're developing, you can see this preview in Xcode's right panel
#Preview {
    ContentView()
}
