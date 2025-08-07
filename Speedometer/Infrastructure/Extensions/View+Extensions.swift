/*
 * VIEW EXTENSIONS - THE STYLING TOOLKIT
 * =====================================
 * 
 * This file contains reusable styling and visual effects that we can apply
 * to different parts of our app. Think of this as a "styling toolkit" that
 * makes our UI look consistent and professional.
 * 
 * WHAT THIS FILE DOES:
 * - Provides reusable styling functions for common UI elements
 * - Defines custom colors that match our speedometer theme
 * - Makes it easy to apply consistent styling across the app
 * - Reduces code duplication and makes maintenance easier
 * 
 * THINK OF IT LIKE THIS:
 * - If our app was a house, this would be like having:
 *   * A paint color palette (our custom colors)
 *   * A set of design templates (our styling functions)
 *   * A style guide that ensures everything matches
 * 
 * WHY WE HAVE THIS:
 * - Instead of repeating the same styling code everywhere
 * - Makes it easy to change the look of the entire app
 * - Ensures visual consistency across all screens
 * - Makes the code more readable and maintainable
 * 
 * COMPONENTS:
 * 1. View Extensions: Reusable styling functions for SwiftUI views
 * 2. Color Extensions: Custom colors that match our speedometer theme
 */

import SwiftUI

// MARK: - View Extensions
/// Extension that adds reusable styling functions to SwiftUI views
/// These are like "styling templates" that we can apply to any view
extension View {
    /// Applies the standard speedometer styling to a view
    /// This includes padding, black background, and dark mode
    /// - Returns: A view with speedometer styling applied
    func speedometerStyle() -> some View {
        self
            .padding()  // Add space around the edges
            .background(Color.black)  // Make the background black
            .preferredColorScheme(.dark)  // Use dark mode
    }
    
    /// Applies error styling to a view (red text, small font)
    /// This is used for error messages throughout the app
    /// - Returns: A view with error styling applied
    func errorStyle() -> some View {
        self
            .foregroundColor(.red)  // Make the text red to indicate error
            .font(.caption)  // Use a small font size
    }
    
    /// Applies the standard speedometer text styling
    /// This is used for the main value display in the center
    /// - Returns: A view with speedometer text styling applied
    func speedometerTextStyle() -> some View {
        self
            .font(.system(size: 36, weight: .bold))  // Large, bold font
            .foregroundColor(Color(red: 0.4, green: 0.7, blue: 0.9))  // Blue color
    }
}

// MARK: - Color Extensions
/// Extension that adds custom colors to SwiftUI's Color type
/// These colors are specifically designed to match our speedometer theme
extension Color {
    /// The main blue color used throughout the speedometer
    /// This is the primary accent color for the app
    static let speedometerBlue = Color(red: 0.36, green: 0.68, blue: 0.89)
    
    /// A darker blue color used for gradients and shadows
    /// This provides depth and contrast to the main blue
    static let speedometerDarkBlue = Color(red: 0.20, green: 0.60, blue: 0.86)
    
    /// The lighter background color for the speedometer dial
    /// This creates the 3D effect on the dial surface
    static let speedometerBackground = Color(red: 0.32, green: 0.35, blue: 0.38)
    
    /// The darker background color for the speedometer dial
    /// This creates the shadow and depth effect
    static let speedometerDarkBackground = Color(red: 0.23, green: 0.24, blue: 0.28)
    
    /// The color for the center hub of the speedometer
    /// This is the small circle where the needle attaches
    static let speedometerHub = Color(red: 0.11, green: 0.12, blue: 0.14)
    
    /// The border color for the center hub
    /// This provides definition and contrast to the hub
    static let speedometerHubBorder = Color(red: 0.17, green: 0.18, blue: 0.20)
}
