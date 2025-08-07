import XCTest
@testable import Speedometer

class SpeedometerValueTests: XCTestCase {
    
    // MARK: - SpeedometerValue Tests
    func testSpeedometerValueInitialization() {
        // Given
        let testValue: Double = 5000
        
        // When
        let speedometerValue = SpeedometerValue(value: testValue)
        
        // Then
        XCTAssertEqual(speedometerValue.value, testValue)
        XCTAssertEqual(speedometerValue.formattedValue, "5.0k")
        XCTAssertGreaterThan(speedometerValue.progress, 0)
        XCTAssertLessThan(speedometerValue.progress, 1)
        XCTAssertNotEqual(speedometerValue.needleAngle, -135) // Should be calculated
    }
    
    func testSpeedometerValueWithZero() {
        // Given
        let testValue: Double = 0
        
        // When
        let speedometerValue = SpeedometerValue(value: testValue)
        
        // Then
        XCTAssertEqual(speedometerValue.value, testValue)
        XCTAssertEqual(speedometerValue.formattedValue, "0")
        XCTAssertEqual(speedometerValue.progress, 0)
        XCTAssertEqual(speedometerValue.needleAngle, -135) // Start angle
    }
    
    func testSpeedometerValueWithMaxValue() {
        // Given
        let testValue: Double = 100000
        
        // When
        let speedometerValue = SpeedometerValue(value: testValue)
        
        // Then
        XCTAssertEqual(speedometerValue.value, testValue)
        XCTAssertEqual(speedometerValue.formattedValue, "100.0k")
        XCTAssertEqual(speedometerValue.progress, 1.0)
        XCTAssertEqual(speedometerValue.needleAngle, 135) // End angle
    }
    
    func testSpeedometerValueEquality() {
        // Given
        let value1 = SpeedometerValue(value: 5000)
        let value2 = SpeedometerValue(value: 5000)
        let value3 = SpeedometerValue(value: 10000)
        
        // Then
        XCTAssertEqual(value1, value2)
        XCTAssertNotEqual(value1, value3)
    }
    
    // MARK: - SpeedometerValueCalculator Tests
    func testCalculateProgressForZero() {
        // Given
        let value: Double = 0
        
        // When
        let progress = SpeedometerValueCalculator.calculateProgress(for: value, maxValue: 100000)
        
        // Then
        XCTAssertEqual(progress, 0.0)
    }
    
    func testCalculateProgressForMaxValue() {
        // Given
        let value: Double = 100000
        
        // When
        let progress = SpeedometerValueCalculator.calculateProgress(for: value, maxValue: 100000)
        
        // Then
        XCTAssertEqual(progress, 1.0)
    }
    
    func testCalculateProgressForMiddleValue() {
        // Given
        let value: Double = 50000
        
        // When
        let progress = SpeedometerValueCalculator.calculateProgress(for: value, maxValue: 100000)
        
        // Then
        XCTAssertGreaterThan(progress, 0.5)
        XCTAssertLessThan(progress, 1.0)
    }
    
    func testCalculateProgressForValueAboveMax() {
        // Given
        let value: Double = 150000
        
        // When
        let progress = SpeedometerValueCalculator.calculateProgress(for: value, maxValue: 100000)
        
        // Then
        XCTAssertEqual(progress, 1.0) // Should be capped
    }
    
    func testCalculateNeedleAngleForZero() {
        // Given
        let progress: Double = 0.0
        
        // When
        let angle = SpeedometerValueCalculator.calculateNeedleAngle(progress: progress)
        
        // Then
        XCTAssertEqual(angle, -135.0) // Start angle
    }
    
    func testCalculateNeedleAngleForMax() {
        // Given
        let progress: Double = 1.0
        
        // When
        let angle = SpeedometerValueCalculator.calculateNeedleAngle(progress: progress)
        
        // Then
        XCTAssertEqual(angle, 135.0) // End angle
    }
    
    func testCalculateNeedleAngleForMiddle() {
        // Given
        let progress: Double = 0.5
        
        // When
        let angle = SpeedometerValueCalculator.calculateNeedleAngle(progress: progress)
        
        // Then
        XCTAssertEqual(angle, 0.0) // Middle angle
    }
    
    // MARK: - SpeedometerValueFormatter Tests
    func testFormatValueZero() {
        // Given
        let value: Double = 0
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "0")
    }
    
    func testFormatValueLessThanThousand() {
        // Given
        let value: Double = 500
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "500")
    }
    
    func testFormatValueThousand() {
        // Given
        let value: Double = 1000
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "1.0k")
    }
    
    func testFormatValueThousands() {
        // Given
        let value: Double = 5000
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "5.0k")
    }
    
    func testFormatValueHundredThousand() {
        // Given
        let value: Double = 100000
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "100.0k")
    }
    
    func testFormatValueAboveHundredThousand() {
        // Given
        let value: Double = 150000
        
        // When
        let formatted = SpeedometerValueFormatter.format(value: value)
        
        // Then
        XCTAssertEqual(formatted, "150.0k")
    }
    
    func testFormatScaleLabelZero() {
        // Given
        let value: Double = 0
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "0")
    }
    
    func testFormatScaleLabelLessThanThousand() {
        // Given
        let value: Double = 500
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "500")
    }
    
    func testFormatScaleLabelThousand() {
        // Given
        let value: Double = 1000
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "1k")
    }
    
    func testFormatScaleLabelThousands() {
        // Given
        let value: Double = 5000
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "5k")
    }
    
    func testFormatScaleLabelHundredThousand() {
        // Given
        let value: Double = 100000
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "100k+")
    }
    
    func testFormatScaleLabelAboveHundredThousand() {
        // Given
        let value: Double = 150000
        
        // When
        let formatted = SpeedometerValueFormatter.formatScaleLabel(value)
        
        // Then
        XCTAssertEqual(formatted, "150k+")
    }
}
