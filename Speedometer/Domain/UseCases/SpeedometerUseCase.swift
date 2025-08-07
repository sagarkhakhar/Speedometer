/*
 * SPEEDOMETER USE CASE - THE BUSINESS LOGIC MANAGER
 * ================================================
 * 
 * This file contains the "business rules" for our speedometer - think of it as the
 * "manager" that knows how to handle speedometer operations.
 * 
 * WHAT THIS FILE DOES:
 * - Validates user input (makes sure numbers are valid)
 * - Creates speedometer values from raw numbers
 * - Provides the scale marks for the dial
 * - Handles the core business logic of the speedometer
 * 
 * THINK OF IT LIKE THIS:
 * - If you're a restaurant manager, this is like the "rules book" that says:
 *   * How to validate customer orders
 *   * How to prepare dishes
 *   * What ingredients are available
 * 
 * WHY WE HAVE THIS:
 * - Separates business logic from the user interface
 * - Makes the code easier to test
 * - Follows clean architecture principles
 * 
 * COMPONENTS:
 * 1. SpeedometerUseCaseProtocol: The "contract" that defines what this use case can do
 * 2. SpeedometerUseCase: The actual implementation that does the work
 */

import Foundation
import Combine

// MARK: - Use Case Protocol (Domain Layer)
/// This protocol defines what our speedometer use case can do
/// Think of this as a "job description" that lists all the responsibilities
protocol SpeedometerUseCaseProtocol {
    /// Updates the speedometer with a new value and returns the result
    /// - Parameter value: The new speed value to display
    /// - Returns: A publisher that provides the calculated speedometer value
    func updateSpeedometer(value: Double) -> AnyPublisher<SpeedometerValue, Never>
    
    /// Checks if the user's input is valid
    /// - Parameter input: The text the user typed
    /// - Returns: true if the input is valid, false otherwise
    func validateInput(_ input: String) -> Bool
    
    /// Gets the scale marks that should appear around the speedometer dial
    /// - Returns: An array of numbers that mark the dial (like [0, 1000, 5000, ...])
    func getScaleMarks() -> [Double]
}

// MARK: - Use Case Implementation
/// The actual implementation of our speedometer business logic
/// This is where all the "work" happens - like the actual restaurant kitchen
class SpeedometerUseCase: SpeedometerUseCaseProtocol {
    /// The highest possible value our speedometer can display
    /// Think of this as the "maximum speed" our speedometer can show
    private let maxValue: Double = 100000
    
    /// The scale marks that appear around our speedometer dial
    /// These are like the numbers on a real speedometer (0, 10, 20, 30, etc.)
    private let scaleMarks: [Double] = [0, 1000, 5000, 10000, 25000, 50000, 100000]
    
    /// Updates the speedometer with a new value
    /// This is like telling the speedometer "show this new speed"
    /// - Parameter value: The new speed value to display
    /// - Returns: A publisher that provides the calculated speedometer value
    func updateSpeedometer(value: Double) -> AnyPublisher<SpeedometerValue, Never> {
        // Create a new speedometer value with all the calculations
        let speedometerValue = SpeedometerValue(value: value, maxValue: maxValue)
        
        // Return it as a publisher (this is how we handle async operations)
        // Just() creates a simple publisher that immediately provides the value
        return Just(speedometerValue)
            .eraseToAnyPublisher()
    }
    
    /// Validates user input to make sure it's a valid number
    /// This is like checking if a customer's order makes sense
    /// - Parameter input: The text the user typed
    /// - Returns: true if the input is valid, false otherwise
    func validateInput(_ input: String) -> Bool {
        // First, try to convert the input to a number
        guard let value = Double(input) else { 
            // If we can't convert it to a number, it's invalid
            return false 
        }
        
        // Make sure the number is not negative (speed can't be negative)
        return value >= 0
    }
    
    /// Gets the scale marks that should appear around the speedometer dial
    /// These are the numbers that help users read the speedometer
    /// - Returns: An array of numbers that mark the dial
    func getScaleMarks() -> [Double] {
        return scaleMarks
    }
}
