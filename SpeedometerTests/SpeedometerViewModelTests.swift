import XCTest
import Combine
@testable import Speedometer

// MARK: - Mock Use Case for Testing
class MockSpeedometerUseCase: SpeedometerUseCaseProtocol {
    var updateSpeedometerCalled = false
    var validateInputCalled = false
    var getScaleMarksCalled = false
    var lastInputValue: String?
    var lastUpdateValue: Double?
    
    var mockScaleMarks: [Double] = [0, 1000, 5000, 10000, 25000, 50000, 100000]
    var mockValidationResult = true
    var mockSpeedometerValue: SpeedometerValue = SpeedometerValue(value: 0)
    
    func updateSpeedometer(value: Double) -> AnyPublisher<SpeedometerValue, Never> {
        updateSpeedometerCalled = true
        lastUpdateValue = value
        return Just(mockSpeedometerValue).eraseToAnyPublisher()
    }
    
    func validateInput(_ input: String) -> Bool {
        validateInputCalled = true
        lastInputValue = input
        return mockValidationResult
    }
    
    func getScaleMarks() -> [Double] {
        getScaleMarksCalled = true
        return mockScaleMarks
    }
}

// MARK: - SpeedometerViewModel Tests
@MainActor
class SpeedometerViewModelTests: XCTestCase {
    var viewModel: SpeedometerViewModel!
    var mockUseCase: MockSpeedometerUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockSpeedometerUseCase()
        viewModel = SpeedometerViewModel(useCase: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    func testInitialization() {
        XCTAssertEqual(viewModel.currentValue.value, 0)
        XCTAssertEqual(viewModel.inputValue, "")
        XCTAssertFalse(viewModel.isAnimating)
        XCTAssertEqual(viewModel.scaleMarks, mockUseCase.mockScaleMarks)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(mockUseCase.getScaleMarksCalled)
    }
    
    // MARK: - Input Validation Tests
    func testValidInputUpdate() {
        // Given
        let testValue = "5000"
        viewModel.inputValue = testValue
        mockUseCase.mockValidationResult = true
        mockUseCase.mockSpeedometerValue = SpeedometerValue(value: 5000)
        
        // When
        viewModel.updateSpeedometer()
        
        // Then
        XCTAssertTrue(mockUseCase.validateInputCalled)
        XCTAssertEqual(mockUseCase.lastInputValue, testValue)
        XCTAssertTrue(mockUseCase.updateSpeedometerCalled)
        XCTAssertEqual(mockUseCase.lastUpdateValue, 5000)
        XCTAssertEqual(viewModel.inputValue, "")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testInvalidInputUpdate() {
        // Given
        let testValue = "invalid"
        viewModel.inputValue = testValue
        mockUseCase.mockValidationResult = false
        
        // When
        viewModel.updateSpeedometer()
        
        // Then
        XCTAssertTrue(mockUseCase.validateInputCalled)
        XCTAssertEqual(mockUseCase.lastInputValue, testValue)
        XCTAssertFalse(mockUseCase.updateSpeedometerCalled)
        XCTAssertEqual(viewModel.inputValue, testValue) // Should not be cleared
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid positive number")
    }
    
    func testEmptyInputUpdate() {
        // Given
        viewModel.inputValue = ""
        
        // When
        viewModel.updateSpeedometer()
        
        // Then
        XCTAssertFalse(mockUseCase.validateInputCalled)
        XCTAssertFalse(mockUseCase.updateSpeedometerCalled)
    }
    
    // MARK: - Direct Value Update Tests
    func testDirectValueUpdate() {
        // Given
        let testValue: Double = 7500
        mockUseCase.mockSpeedometerValue = SpeedometerValue(value: testValue)
        
        // When
        viewModel.updateSpeedometer(from: testValue)
        
        // Then
        XCTAssertTrue(mockUseCase.updateSpeedometerCalled)
        XCTAssertEqual(mockUseCase.lastUpdateValue, testValue)
        XCTAssertTrue(viewModel.isAnimating)
    }
    
    // MARK: - Error Handling Tests
    func testClearError() {
        // Given
        viewModel.errorMessage = "Test error"
        
        // When
        viewModel.clearError()
        
        // Then
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // MARK: - Animation State Tests
    func testAnimationStateAfterUpdate() {
        // Given
        let testValue: Double = 10000
        mockUseCase.mockSpeedometerValue = SpeedometerValue(value: testValue)
        
        // When
        viewModel.updateSpeedometer(from: testValue)
        
        // Then
        XCTAssertTrue(viewModel.isAnimating)
        
        // Wait for animation to complete
        let expectation = XCTestExpectation(description: "Animation completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            XCTAssertFalse(self.viewModel.isAnimating)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
