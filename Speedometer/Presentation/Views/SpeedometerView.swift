/*
 * SPEEDOMETER VIEW - THE MAIN USER INTERFACE
 * =========================================
 * 
 * This file contains all the visual components of our speedometer - everything
 * that users see and interact with. Think of this as the "face" of our app.
 * 
 * WHAT THIS FILE DOES:
 * - Shows the speedometer dial with needle and progress arc
 * - Displays the current speed value in the center
 * - Shows scale labels around the dial
 * - Provides input controls for users to enter new values
 * - Handles all the visual animations and effects
 * 
 * THINK OF IT LIKE THIS:
 * - This is like the dashboard of a car - it shows:
 *   * The speedometer dial (like a real car's speedometer)
 *   * The current speed (like the digital display)
 *   * The input controls (like the gas pedal and brake)
 * 
 * COMPONENTS:
 * 1. SpeedometerView: The main container that holds everything
 * 2. SpeedometerDialView: The actual speedometer dial with needle
 * 3. ScaleLabelsView: The numbers around the dial
 * 4. CenterHubView: The center circle of the speedometer
 * 5. NeedleView: The moving needle that points to the current speed
 * 6. ValueDisplayView: The large number in the center
 * 7. InputControlsView: The text field and button for user input
 */

import SwiftUI

// MARK: - Main Speedometer View
/// The main view that contains the entire speedometer interface
/// This is like the "main screen" of our app - everything is organized here
struct SpeedometerView: View {
    /// The ViewModel that manages our data and business logic
    /// This is like having a "brain" that controls what we show
    @StateObject private var viewModel: SpeedometerViewModel
    
    /// Creates a new SpeedometerView with all its dependencies
    /// This sets up the "pipeline" from UI to business logic
    init() {
        // Create the business logic component (UseCase)
        let useCase = SpeedometerUseCase()
        
        // Create the ViewModel that connects UI to business logic
        self._viewModel = StateObject(wrappedValue: SpeedometerViewModel(useCase: useCase))
    }
    
    /// This defines what our speedometer screen looks like
    /// Think of this as the "blueprint" for our user interface
    var body: some View {
        // VStack arranges everything vertically (top to bottom)
        VStack(spacing: 30) {
            // Top-left faint label - just for visual design
            HStack {
                Text("Frame")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.leading, 12)
                Spacer()  // This pushes the text to the left
            }
            
            // The main speedometer dial - this is the star of the show!
            SpeedometerDialView(
                currentValue: viewModel.currentValue,      // The current speed data
                scaleMarks: viewModel.scaleMarks,          // The numbers around the dial
                isAnimating: viewModel.isAnimating         // Whether it's currently moving
            )
            
            // The input controls at the bottom - where users enter new speeds
            InputControlsView(
                inputValue: $viewModel.inputValue,         // The text field content
                isAnimating: viewModel.isAnimating,        // Whether we're animating
                errorMessage: viewModel.errorMessage,      // Any error messages
                onUpdate: viewModel.updateSpeedometer      // What happens when button is tapped
            )
            
            // This pushes everything up and creates space at the bottom
            Spacer()
        }
        .padding()  // Add some space around the edges
        .background(Color.black)  // Make the background black
        .preferredColorScheme(.dark)  // Use dark mode
    }
}

// MARK: - Speedometer Dial View
/// The actual speedometer dial - the circular part with the needle
/// This is like the "face" of a real speedometer
struct SpeedometerDialView: View {
    /// The current speed data (value, formatted text, needle angle, etc.)
    let currentValue: SpeedometerValue
    
    /// The scale marks that appear around the dial (like 0, 1k, 5k, etc.)
    let scaleMarks: [Double]
    
    /// Whether the speedometer is currently animating
    let isAnimating: Bool
    
    /// This defines what our speedometer dial looks like
    var body: some View {
        // ZStack layers things on top of each other (like stacking papers)
        ZStack {
            // Outer ring - the metal ring around the speedometer
            Circle()
                .stroke(Color(red: 0.75, green: 0.75, blue: 0.75), lineWidth: 10)
                .frame(width: 270, height: 270)
            
            // Background dial - the main circular background
            Circle()
                .fill(
                    // This creates a 3D effect with a gradient
                    RadialGradient(
                        colors: [
                            Color(red: 0.32, green: 0.35, blue: 0.38),  // Lighter gray
                            Color(red: 0.23, green: 0.24, blue: 0.28)   // Darker gray
                        ],
                        center: .init(x: 0.3, y: 0.3),  // Offset the gradient for 3D effect
                        startRadius: 0,
                        endRadius: 130
                    )
                )
                .frame(width: 260, height: 260)
                .shadow(color: .black.opacity(0.6), radius: 12)  // Add shadow for depth
            
            // Background progress arc - the gray arc that shows the full range
            ArcShape(
                startAngle: .degrees(-135),  // Start at -135 degrees
                endAngle: .degrees(135),     // End at +135 degrees
                clockwise: false             // Draw counter-clockwise
            )
            .stroke(Color.gray.opacity(0.4), lineWidth: 8)
            .frame(width: 270, height: 270)
            
            // Progress arc with animation - the blue arc that fills as speed increases
            ArcShape(
                startAngle: .degrees(-222),  // Start angle for the progress arc
                endAngle: .degrees(40),      // End angle for the progress arc
                clockwise: false             // Draw counter-clockwise
            )
            .trim(from: 0, to: currentValue.progress)  // Only show part of the arc based on progress
            .stroke(
                Color(red: 0.36, green: 0.68, blue: 0.89),  // Blue color
                style: StrokeStyle(lineWidth: 8, lineCap: .round)  // Rounded ends
            )
            .frame(width: 270, height: 270)
            .animation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0.3), value: currentValue.progress)
            
            // Scale labels - the numbers around the dial (0, 1k, 5k, etc.)
            ScaleLabelsView(scaleMarks: scaleMarks)
            
            // Center hub - the small circle in the center where the needle attaches
            CenterHubView()
            
            // Needle with smooth animation - the moving pointer that shows the current speed
            NeedleView(angle: currentValue.needleAngle, isAnimating: isAnimating)
                .animation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0.3), value: currentValue.needleAngle)
            
            // Current value display - the large number in the center
            ValueDisplayView(value: currentValue.formattedValue, isAnimating: isAnimating)
        }
        .frame(width: 300, height: 300)  // Set the overall size
    }
}

// MARK: - Scale Labels View
/// The numbers that appear around the speedometer dial
/// These help users read the speedometer (like the numbers on a real speedometer)
struct ScaleLabelsView: View {
    /// The scale marks to display (like [0, 1000, 5000, 10000, ...])
    let scaleMarks: [Double]
    
    /// This defines what our scale labels look like
    var body: some View {
        // ForEach creates one label for each scale mark
        ForEach(Array(scaleMarks.enumerated()), id: \.offset) { index, value in
            // Calculate the angle for this label
            let angle = -135 + (Double(index) * 45)  // Space labels 45 degrees apart
            
            // Format the value for display (like "0", "1k", "5k")
            let labelText = SpeedometerValueFormatter.formatScaleLabel(value)
            
            // Create the text label
            Text(labelText)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .rotationEffect(.degrees(-angle))  // Rotate the text to be horizontal
                .offset(y: -110)  // Move it outward from the center
                .rotationEffect(.degrees(angle))   // Rotate it back to the correct position
                .offset(x: getLabelOffset(for: index, angle: angle))  // Fine-tune the position
                .shadow(color: .black.opacity(0.8), radius: 2, x: 1, y: 1)  // Add shadow for readability
        }
    }
    
    /// Adjusts the horizontal position of labels to prevent overlapping
    /// - Parameter index: Which label this is (0, 1, 2, etc.)
    /// - Parameter angle: The angle where this label should appear
    /// - Returns: How much to offset the label horizontally
    private func getLabelOffset(for index: Int, angle: Double) -> CGFloat {
        // For now, we don't need any special offset adjustments
        switch index {
        case 0...6:
            return 0
        default:
            return 0
        }
    }
}

// MARK: - Center Hub View
/// The small circle in the center of the speedometer where the needle attaches
/// This is like the "hub" of a real speedometer
struct CenterHubView: View {
    /// This defines what our center hub looks like
    var body: some View {
        Circle()
            .fill(
                // Create a 3D effect with a radial gradient
                RadialGradient(
                    colors: [
                        Color(red: 0.11, green: 0.12, blue: 0.14),  // Dark gray
                        Color.black                                  // Black
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: 16
                )
            )
            .frame(width: 32, height: 32)  // Make it 32x32 pixels
            .overlay(
                // Add a subtle border for definition
                Circle()
                    .stroke(Color(red: 0.17, green: 0.18, blue: 0.20), lineWidth: 2)
            )
    }
}

// MARK: - Needle View
/// The moving needle that points to the current speed
/// This is like the "hand" of a clock that moves around
struct NeedleView: View {
    /// The angle where the needle should point (in degrees)
    let angle: Double
    
    /// Whether the needle is currently animating
    let isAnimating: Bool
    
    /// This defines what our needle looks like
    var body: some View {
        Rectangle()
            .fill(
                // Create a gradient effect on the needle
                LinearGradient(
                    colors: [
                        Color(red: 0.36, green: 0.68, blue: 0.89),  // Light blue
                        Color(red: 0.20, green: 0.60, blue: 0.86)   // Dark blue
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 4, height: 95)  // Make it thin and long
            .cornerRadius(2)  // Round the corners slightly
            .offset(y: -47.5)  // Move it up so it pivots from the center
            .rotationEffect(.degrees(angle))  // Rotate it to the correct angle
            .shadow(
                color: Color(red: 0.36, green: 0.68, blue: 0.89).opacity(isAnimating ? 0.8 : 0.5),
                radius: isAnimating ? 8 : 5
            )  // Add a glowing effect when animating
            .scaleEffect(isAnimating ? 1.05 : 1.0)  // Make it slightly larger when animating
            .animation(.easeInOut(duration: 0.3), value: isAnimating)  // Smooth the animation
    }
}

// MARK: - Value Display View
/// The large number that appears in the center of the speedometer
/// This shows the current speed in a big, easy-to-read format
struct ValueDisplayView: View {
    /// The formatted value to display (like "50", "1.0k", "50.0k")
    let value: String
    
    /// Whether the value is currently animating
    let isAnimating: Bool
    
    /// This defines what our value display looks like
    var body: some View {
        VStack {
            Spacer()  // Push the text to the bottom of the available space
            Text(value)
                .font(.system(size: 36, weight: .bold))  // Make it big and bold
                .foregroundColor(Color(red: 0.4, green: 0.7, blue: 0.9))  // Blue color
                .padding(.bottom, 35)  // Add some space below
                .scaleEffect(isAnimating ? 1.1 : 1.0)  // Make it slightly larger when animating
                .animation(.easeInOut(duration: 0.3), value: isAnimating)  // Smooth the animation
        }
    }
}

// MARK: - Input Controls View
/// The input controls at the bottom of the screen
/// This includes the text field and button for entering new speeds
struct InputControlsView: View {
    /// The text that the user has typed (two-way binding)
    @Binding var inputValue: String
    
    /// Whether the speedometer is currently animating
    let isAnimating: Bool
    
    /// Any error message to display
    let errorMessage: String?
    
    /// What to do when the update button is tapped
    let onUpdate: () -> Void
    
    /// This defines what our input controls look like
    var body: some View {
        VStack(spacing: 20) {
            // Text field where users enter new speed values
            TextField("Enter value (0-999999)", text: $inputValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())  // Give it rounded borders
                .keyboardType(.numberPad)  // Show number keyboard on iPhone
                .frame(maxWidth: 250)  // Limit the width
                .disabled(isAnimating)  // Disable when animating
            
            // Show error message if there is one
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)  // Make it red to indicate error
                    .font(.caption)  // Make it smaller
            }
            
            // Update button that triggers the speedometer update
            Button("Update Speedometer") {
                onUpdate()  // Call the update function when tapped
            }
            .buttonStyle(.borderedProminent)  // Make it look like a prominent button
            .disabled(inputValue.isEmpty || isAnimating)  // Disable if no input or animating
            .scaleEffect(isAnimating ? 0.95 : 1.0)  // Make it slightly smaller when animating
            .animation(.easeInOut(duration: 0.2), value: isAnimating)  // Smooth the animation
        }
    }
}
