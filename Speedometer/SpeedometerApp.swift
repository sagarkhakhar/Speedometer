/*
 * SPEEDOMETER APP - MAIN ENTRY POINT
 * ===================================
 * 
 * This is the starting point of our Speedometer app - like the "main door" to our house.
 * When you launch the app, this file tells your iPhone/iPad what to show first.
 * 
 * Think of this as the "boss" that sets up everything and decides what screen to show.
 * 
 * WHAT THIS FILE DOES:
 * - Tells iOS "Hey, this is where my app starts!"
 * - Sets up the main window (like opening a window in your house)
 * - Shows the SpeedometerView as the first thing users see
 * 
 * TECHNICAL DETAILS:
 * - @main: This special tag tells iOS "Start here!"
 * - App: This is a SwiftUI protocol that every iOS app needs
 * - WindowGroup: Creates the main window for our app
 * - SpeedometerView(): This is our main speedometer screen
 */

import SwiftUI

/// Main entry point for the Speedometer app
/// This is like the "front door" of our app - everything starts here
@main
struct SpeedometerApp: App {
    /// This is the main body of our app - it defines what the app looks like
    /// Think of this as the "blueprint" for our app's main window
    var body: some Scene {
        // WindowGroup creates the main window that users see
        // It's like creating a window in your house where people can look inside
        WindowGroup {
            // SpeedometerView() is our main screen - the speedometer itself
            // This is what users will see when they open the app
            SpeedometerView()
        }
    }
}
