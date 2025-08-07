/*
 * SPEEDOMETER VIEW MODEL - THE BRIDGE BETWEEN UI AND BUSINESS LOGIC
 * ================================================================
 * 
 * This file acts as a "translator" between what the user sees (the UI) and what
 * the business logic does. Think of it as an interpreter that speaks both languages.
 * 
 * WHAT THIS FILE DOES:
 * - Manages the data that the UI displays
 * - Handles user interactions (like button taps)
 * - Communicates with the business logic (UseCase)
 * - Manages animations and state changes
 * - Provides error messages to the user
 * 
 * THINK OF IT LIKE THIS:
 * - If the UI is like a waiter taking orders, and the UseCase is like the kitchen,
 *   then the ViewModel is like the manager who:
 *   * Takes orders from the waiter
 *   * Communicates with the kitchen
 *   * Makes sure everything runs smoothly
 *   * Handles any problems that come up
 * 
 * WHY WE HAVE THIS:
 * - Separates UI logic from business logic
 * - Makes the code easier to test
 * - Follows the MVVM (Model-View-ViewModel) pattern
 * - Handles complex state management
 * 
 * COMPONENTS:
 * 1. SpeedometerViewModelProtocol: The "contract" that defines what the ViewModel can do
 * 2. SpeedometerViewModel: The actual implementation that manages the UI state
 */

import Foundation
import Combine
import SwiftUI

// MARK: - ViewModel Protocol (SOLID - Dependency Inversion)
/// This protocol defines what our ViewModel can do
/// Think of this as a "job description" for the ViewModel
protocol SpeedometerViewModelProtocol: ObservableObject {
    /// The current speedometer value being displayed
    var currentValue: SpeedometerValue { get }
    
    /// The text the user has typed in the input field
    var inputValue: String { get set }
    
    /// Whether the speedometer is currently animating
    var isAnimating: Bool { get }
    
    /// The scale marks that appear around the speedometer dial
    var scaleMarks: [Double] { get }
    
    /// Any error message that should be shown to the user
    var errorMessage: String? { get }
    
    /// Updates the speedometer with the value from the input field
    func updateSpeedometer()
    
    /// Updates the speedometer with a specific value
    /// - Parameter value: The new speed value to display
    func updateSpeedometer(from value: Double)
    
    /// Clears any error message that's currently being shown
    func clearError()
}

// MARK: - ViewModel Implementation
/// The actual implementation of our ViewModel
/// This is where all the UI state management happens
@MainActor
class SpeedometerViewModel: SpeedometerViewModelProtocol {
    // MARK: - Published Properties
    /// The current speedometer value being displayed
    /// This automatically updates the UI when it changes
    @Published private(set) var currentValue: SpeedometerValue = SpeedometerValue(value: 0)
    
    /// The text the user has typed in the input field
    /// This is a two-way binding - changes in the UI update this, and changes here update the UI
    @Published var inputValue: String = ""
    
    /// Whether the speedometer is currently animating
    /// This controls visual effects like glowing needles and scaling
    @Published private(set) var isAnimating: Bool = false
    
    /// The scale marks that appear around the speedometer dial
    /// These are the numbers that help users read the speedometer
    @Published private(set) var scaleMarks: [Double] = []
    
    /// Any error message that should be shown to the user
    /// This appears when the user enters invalid input
    @Published var errorMessage: String?
    
    // MARK: - Dependencies (SOLID - Dependency Inversion)
    /// The business logic component that handles speedometer operations
    /// This is like having a connection to the "kitchen" (business logic)
    private let useCase: SpeedometerUseCaseProtocol
    
    /// A collection of subscriptions that need to be cleaned up
    /// This prevents memory leaks when the ViewModel is destroyed
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    /// Creates a new ViewModel with the required dependencies
    /// - Parameter useCase: The business logic component to use
    init(useCase: SpeedometerUseCaseProtocol) {
        self.useCase = useCase
        // Get the scale marks from the business logic
        self.scaleMarks = useCase.getScaleMarks()
        // Start with a demonstration animation
        setupInitialAnimation()
    }
    
    // MARK: - Public Methods
    /// Updates the speedometer with the value from the input field
    /// This is called when the user taps the "Update Speedometer" button
    func updateSpeedometer() {
        // Don't do anything if the input field is empty
        guard !inputValue.isEmpty else { return }
        
        // Check if the user's input is valid
        if useCase.validateInput(inputValue) {
            // Try to convert the input to a number
            guard let value = Double(inputValue) else { return }
            
            // Update the speedometer with the new value
            updateSpeedometer(from: value)
            
            // Clear the input field after successful update
            inputValue = ""
            
            // Clear any previous error messages
            clearError()
        } else {
            // Show an error message if the input is invalid
            errorMessage = "Please enter a valid positive number"
        }
    }
    
    /// Updates the speedometer with a specific value
    /// This is the main method that handles speedometer updates
    /// - Parameter value: The new speed value to display
    func updateSpeedometer(from value: Double) {
        // Start the animation state
        isAnimating = true
        
        // Ask the business logic to update the speedometer
        useCase.updateSpeedometer(value: value)
            .receive(on: DispatchQueue.main)  // Make sure we update the UI on the main thread
            .sink { [weak self] speedometerValue in
                guard let self = self else { return }
                
                // Update the current value with a smooth animation
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0.3)) {
                    self.currentValue = speedometerValue
                }
            }
            .store(in: &cancellables)  // Remember to clean up this subscription later
        
        // Stop the animation after a delay
        // This gives the needle time to move to its new position
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.isAnimating = false
        }
    }
    
    /// Clears any error message that's currently being shown
    /// This is called when the user enters valid input
    func clearError() {
        errorMessage = nil
    }
    
    // MARK: - Private Methods
    /// Sets up the initial demonstration animation
    /// This shows users how the speedometer works when the app starts
    private func setupInitialAnimation() {
        // Start with a demonstration animation from 0 to 15200
        // This happens 0.5 seconds after the app starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateSpeedometer(from: 0)
        }
    }
}
