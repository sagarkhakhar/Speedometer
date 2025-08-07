/*
 * DEPENDENCY CONTAINER - THE SERVICE MANAGER
 * =========================================
 * 
 * This file manages how different parts of our app connect to each other.
 * Think of it as a "service desk" that knows how to create and provide
 * all the different components our app needs.
 * 
 * WHAT THIS FILE DOES:
 * - Creates and manages all the different components (UseCases, ViewModels, etc.)
 * - Ensures components are created in the right order
 * - Makes it easy to swap out different implementations
 * - Prevents memory leaks and manages object lifecycles
 * 
 * THINK OF IT LIKE THIS:
 * - If our app was a restaurant, this would be like the manager who:
 *   * Knows how to hire and train all the staff
 *   * Makes sure everyone has the tools they need
 *   * Can replace a cook if they're sick
 *   * Ensures the kitchen and dining room work together
 * 
 * WHY WE HAVE THIS:
 * - Makes the code more testable (we can swap real components with fake ones)
 * - Follows dependency injection principles
 * - Makes the code more modular and flexible
 * - Prevents tight coupling between components
 * 
 * COMPONENTS:
 * 1. DependencyContainerProtocol: The "contract" that defines what the container can do
 * 2. DependencyContainer: The actual implementation that manages dependencies
 * 3. setup(): A helper function that configures all the dependencies
 */

import Foundation

// MARK: - Dependency Container Protocol
/// This protocol defines what our dependency container can do
/// Think of this as a "job description" for the dependency manager
protocol DependencyContainerProtocol {
    /// Gets an instance of a specific type from the container
    /// - Returns: An instance of the requested type
    func resolve<T>() -> T
    
    /// Registers a factory function for creating a specific type
    /// - Parameter type: The type to register (like SpeedometerUseCaseProtocol.self)
    /// - Parameter factory: A function that creates an instance of that type
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
}

// MARK: - Dependency Container Implementation
/// The actual implementation of our dependency container
/// This is where all the "magic" happens - creating and managing components
class DependencyContainer: DependencyContainerProtocol {
    /// A dictionary that stores factory functions for creating different types
    /// Think of this as a "recipe book" where each recipe creates a different component
    private var factories: [String: () -> Any] = [:]
    
    /// Registers a factory function for creating a specific type
    /// This is like adding a recipe to our recipe book
    /// - Parameter type: The type to register (like SpeedometerUseCaseProtocol.self)
    /// - Parameter factory: A function that creates an instance of that type
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        // Use the type name as the key (like "SpeedometerUseCaseProtocol")
        let key = String(describing: type)
        
        // Store the factory function in our recipe book
        factories[key] = factory
    }
    
    /// Gets an instance of a specific type from the container
    /// This is like asking the kitchen to make a dish using a recipe
    /// - Returns: An instance of the requested type
    func resolve<T>() -> T {
        // Get the type name as the key
        let key = String(describing: T.self)
        
        // Look up the factory function in our recipe book
        guard let factory = factories[key] else {
            // If we don't have a recipe for this type, crash with a helpful error
            fatalError("No factory registered for type: \(T.self)")
        }
        
        // Use the factory to create an instance
        guard let instance = factory() as? T else {
            // If the factory didn't return the right type, crash with a helpful error
            fatalError("Factory did not return expected type: \(T.self)")
        }
        
        // Return the created instance
        return instance
    }
}

// MARK: - Dependency Injection Setup
/// Extension that provides a convenient way to set up all dependencies
/// This is like having a "setup wizard" that configures everything automatically
extension DependencyContainer {
    /// Creates and configures a dependency container with all the necessary components
    /// This is the main setup function that gets called when the app starts
    /// - Returns: A fully configured dependency container
    static func setup() -> DependencyContainer {
        // Create a new empty container
        let container = DependencyContainer()
        
        // Register all our components with their factory functions
        // This is like adding all the recipes to our recipe book
        
        // Register the Use Case (business logic)
        container.register(SpeedometerUseCaseProtocol.self) {
            // This factory function creates a new SpeedometerUseCase
            SpeedometerUseCase()
        }
        
        // In the future, we could add more registrations here:
        // container.register(SomeOtherProtocol.self) { SomeOtherImplementation() }
        // container.register(AnotherProtocol.self) { AnotherImplementation() }
        
        // Return the fully configured container
        return container
    }
}
