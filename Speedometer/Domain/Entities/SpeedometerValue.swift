/*
 * SPEEDOMETER VALUE - THE HEART OF OUR SPEEDOMETER
 * ================================================
 * 
 * This file contains the "data model" for our speedometer - think of it as the "brain"
 * that knows everything about a speed value and how to display it.
 * 
 * WHAT THIS FILE DOES:
 * - Stores a speed value (like 50, 1000, 50000)
 * - Calculates how the needle should move
 * - Formats the value for display (like "50", "1.0k", "50.0k")
 * - Calculates the progress bar position
 * 
 * THINK OF IT LIKE THIS:
 * - If you have a speed of 5000, this file knows:
 *   * How to show it as "5.0k"
 *   * Where the needle should point
 *   * How much of the progress arc should be filled
 * 
 * COMPONENTS:
 * 1. SpeedometerValue: The main data structure (like a container)
 * 2. SpeedometerValueCalculator: Does all the math (like a calculator)
 * 3. SpeedometerValueFormatter: Makes numbers look pretty (like a formatter)
 */

import Foundation

// MARK: - Domain Entity
/// The main data structure that represents a speedometer value
/// This is like a "package" that contains all the information about a speed
struct SpeedometerValue: Equatable {
    /// The actual numeric value (like 5000.0)
    let value: Double
    
    /// The formatted string for display (like "5.0k")
    let formattedValue: String
    
    /// How much of the progress arc should be filled (0.0 to 1.0)
    /// Think of this as a percentage: 0.0 = empty, 1.0 = full
    let progress: Double
    
    /// The angle where the needle should point (in degrees)
    /// This tells the needle exactly where to point on the dial
    let needleAngle: Double
    
    /// Creates a new speedometer value
    /// - Parameter value: The actual speed number (like 5000)
    /// - Parameter maxValue: The highest possible value (default: 100,000)
    init(value: Double, maxValue: Double = 100000) {
        self.value = value
        // Format the value for display (like "5.0k" instead of "5000")
        self.formattedValue = SpeedometerValueFormatter.format(value: value)
        // Calculate how much of the progress arc should be filled
        self.progress = SpeedometerValueCalculator.calculateProgress(for: value, maxValue: maxValue)
        // Calculate where the needle should point based on the progress
        self.needleAngle = SpeedometerValueCalculator.calculateNeedleAngle(progress: self.progress)
    }
}

// MARK: - Value Calculator (Domain Logic)
/// This struct contains all the math calculations for the speedometer
/// Think of this as a "smart calculator" that knows how speedometers work
struct SpeedometerValueCalculator {
    /// The starting angle of our speedometer dial (in degrees)
    /// Our speedometer goes from -135° to +135° (total of 270°)
    private static let startAngle: Double = -135.0
    
    /// The ending angle of our speedometer dial (in degrees)
    private static let endAngle: Double = 135.0
    
    /// The total range of angles our speedometer covers
    private static let totalAngleRange = endAngle - startAngle
    
    /// The scale marks on our speedometer (like the numbers on a real speedometer)
    /// These are the "checkpoints" that help us calculate positions
    private static let scaleMarks: [Double] = [0, 1000, 5000, 10000, 25000, 50000, 100000]
    
    /// Calculates how much of the progress arc should be filled
    /// This is like calculating what percentage of a pie chart should be colored
    /// - Parameter value: The current speed value
    /// - Parameter maxValue: The maximum possible value
    /// - Returns: A number between 0.0 (empty) and 1.0 (full)
    static func calculateProgress(for value: Double, maxValue: Double) -> Double {
        // Make sure we don't exceed the maximum value
        let cappedValue = min(value, maxValue)
        
        // Find which scale mark range our value falls into
        // For example: if value is 7500, it falls between 5000 and 10000
        for i in 0..<(scaleMarks.count - 1) {
            let currentMark = scaleMarks[i]      // Like 5000
            let nextMark = scaleMarks[i + 1]     // Like 10000
            
            // Check if our value is between these two marks
            if cappedValue >= currentMark && cappedValue <= nextMark {
                // Calculate how far we are between these two marks
                let range = nextMark - currentMark                    // Like 5000 (10000 - 5000)
                let segmentProgress = (cappedValue - currentMark) / range  // Like 0.5 (2500 / 5000)
                
                // Calculate the overall progress for these two marks
                let currentProgress = Double(i) / Double(scaleMarks.count - 1)           // Like 0.33
                let nextProgress = Double(i + 1) / Double(scaleMarks.count - 1)          // Like 0.5
                
                // Interpolate between the two progress values
                // This gives us a smooth transition between scale marks
                return currentProgress + (segmentProgress * (nextProgress - currentProgress))
            }
        }
        
        // If the value is beyond our highest scale mark, show it as full
        return 1.0
    }
    
    /// Calculates the angle where the needle should point
    /// This converts our progress (0.0 to 1.0) into an actual angle (-135° to +135°)
    /// - Parameter progress: How much of the arc is filled (0.0 to 1.0)
    /// - Returns: The angle in degrees where the needle should point
    static func calculateNeedleAngle(progress: Double) -> Double {
        // Convert progress to an angle within our speedometer's range
        let currentAngle = startAngle + (totalAngleRange * progress)
        return currentAngle
    }
}

// MARK: - Value Formatter (Domain Logic)
/// This struct handles making numbers look pretty for display
/// Think of this as a "number beautifier" that makes large numbers easier to read
struct SpeedometerValueFormatter {
    /// Formats a number for display in the center of the speedometer
    /// - Parameter value: The number to format
    /// - Returns: A formatted string (like "50", "1.0k", "50.0k")
    static func format(value: Double) -> String {
        if value >= 100000 {
            // For very large numbers, show as "100.0k" format
            return String(format: "%.1fk", value / 1000)
        } else if value >= 1000 {
            // For large numbers, show as "1.0k" format
            return String(format: "%.1fk", value / 1000)
        } else {
            // For small numbers, show as whole numbers
            return String(format: "%.0f", value)
        }
    }
    
    /// Formats a number for display on the scale labels around the dial
    /// - Parameter value: The number to format
    /// - Returns: A formatted string for scale labels (like "0", "1k", "100k+")
    static func formatScaleLabel(_ value: Double) -> String {
        if value >= 100000 {
            // For the highest mark, show "100k+"
            return "100k+"
        } else if value >= 1000 {
            // For large numbers, show as "1k" format
            return "\(Int(value / 1000))k"
        } else {
            // For small numbers, show as whole numbers
            return "\(Int(value))"
        }
    }
}
