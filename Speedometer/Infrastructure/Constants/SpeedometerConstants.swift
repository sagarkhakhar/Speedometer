/*
 * SPEEDOMETER CONSTANTS - THE CONFIGURATION HUB
 * ============================================
 * 
 * This file contains all the "settings" and "numbers" that control how our
 * speedometer looks and behaves. Think of this as the "control panel" where
 * we can adjust everything.
 * 
 * WHAT THIS FILE DOES:
 * - Defines all the sizes, colors, and timing values
 * - Makes it easy to change how the speedometer looks
 * - Keeps all configuration in one place
 * - Makes the code more maintainable and organized
 * 
 * THINK OF IT LIKE THIS:
 * - If our speedometer was a car, this file would contain:
 *   * The size of the wheels
 *   * The color of the paint
 *   * How fast the engine revs
 *   * The dimensions of the dashboard
 * 
 * WHY WE HAVE THIS:
 * - Instead of having numbers scattered throughout the code
 * - Makes it easy to change values without hunting through files
 * - Ensures consistency across the entire app
 * - Makes the code more readable and professional
 * 
 * COMPONENTS:
 * 1. Animation: Timing and animation settings
 * 2. Layout: Sizes and positioning values
 * 3. Angles: Mathematical angle calculations
 * 4. Values: Speed and scale settings
 * 5. Spacing: Distance and padding values
 * 6. Shadows: Visual depth effects
 * 7. Scale: Animation scaling values
 * 8. Fonts: Text size settings
 */

import Foundation
import SwiftUI

// MARK: - Speedometer Constants
/// The main container for all speedometer configuration values
/// This is like a "settings book" where we keep all our important numbers
struct SpeedometerConstants {
    
    // MARK: - Animation Constants
    /// All the timing and animation-related settings
    /// These control how smooth and responsive our animations feel
    struct Animation {
        /// How long basic animations take (in seconds)
        static let duration: Double = 0.3
        
        /// How responsive the spring animation is (lower = more responsive)
        static let springResponse: Double = 0.8
        
        /// How much the spring animation bounces (lower = more bouncy)
        static let springDampingFraction: Double = 0.6
        
        /// How long the spring animation blends (in seconds)
        static let springBlendDuration: Double = 0.3
        
        /// How long to wait before stopping the animation state
        static let resetDelay: Double = 1.2
        
        /// How long to wait before starting the initial demo animation
        static let initialAnimationDelay: Double = 0.5
    }
    
    // MARK: - Layout Constants
    /// All the size and positioning values for the speedometer
    /// These control how big and where everything appears on screen
    struct Layout {
        /// The size of the outer dial ring (in pixels)
        static let dialSize: CGFloat = 270
        
        /// The size of the inner dial background (in pixels)
        static let innerDialSize: CGFloat = 260
        
        /// The total size of the speedometer container (in pixels)
        static let containerSize: CGFloat = 300
        
        /// The thickness of the outer ring (in pixels)
        static let outerRingWidth: CGFloat = 10
        
        /// The thickness of the progress arc (in pixels)
        static let progressArcWidth: CGFloat = 8
        
        /// The width of the needle (in pixels)
        static let needleWidth: CGFloat = 4
        
        /// The height of the needle (in pixels)
        static let needleHeight: CGFloat = 95
        
        /// How far to offset the needle from center (in pixels)
        static let needleOffset: CGFloat = -47.5
        
        /// The size of the center hub circle (in pixels)
        static let hubSize: CGFloat = 32
        
        /// The thickness of the hub border (in pixels)
        static let hubBorderWidth: CGFloat = 2
        
        /// How far out the scale labels are positioned (in pixels)
        static let labelOffset: CGFloat = -110
        
        /// How much space below the value display (in pixels)
        static let valueDisplayBottomPadding: CGFloat = 35
        
        /// The maximum width of the input field (in pixels)
        static let inputFieldMaxWidth: CGFloat = 250
    }
    
    // MARK: - Angle Constants
    /// All the mathematical angle values for the speedometer
    /// These control how the dial and needle are positioned
    struct Angles {
        /// The starting angle of the speedometer dial (in degrees)
        static let startAngle: Double = -135.0
        
        /// The ending angle of the speedometer dial (in degrees)
        static let endAngle: Double = 135.0
        
        /// The starting angle of the progress arc (in degrees)
        static let progressStartAngle: Double = -222.0
        
        /// The ending angle of the progress arc (in degrees)
        static let progressEndAngle: Double = 40.0
        
        /// How many degrees between each scale label (in degrees)
        static let labelAngleStep: Double = 45.0
    }
    
    // MARK: - Value Constants
    /// All the speed and scale-related values
    /// These control the range and scale of the speedometer
    struct Values {
        /// The minimum speed value (can't go below this)
        static let minValue: Double = 0
        
        /// The maximum speed value (can't go above this)
        static let maxValue: Double = 100000
        
        /// The scale marks that appear around the dial
        /// These are like the numbers on a real speedometer
        static let scaleMarks: [Double] = [0, 1000, 5000, 10000, 25000, 50000, 100000]
        
        /// The initial value for the demo animation
        static let initialDemoValue: Double = 0
    }
    
    // MARK: - Spacing Constants
    /// All the spacing and padding values
    /// These control how much space is between different elements
    struct Spacing {
        /// How much space between main elements in the vertical stack (in pixels)
        static let mainVStackSpacing: CGFloat = 30
        
        /// How much space between input control elements (in pixels)
        static let inputControlsSpacing: CGFloat = 20
        
        /// How much space from the left edge for the top label (in pixels)
        static let topLabelLeadingPadding: CGFloat = 12
    }
    
    // MARK: - Shadow Constants
    /// All the shadow and depth effect values
    /// These control how 3D and realistic the speedometer looks
    struct Shadows {
        /// How blurry the dial shadow is (in pixels)
        static let dialShadowRadius: CGFloat = 12
        
        /// How transparent the dial shadow is (0.0 = invisible, 1.0 = solid)
        static let dialShadowOpacity: Double = 0.6
        
        /// How blurry the label shadows are (in pixels)
        static let labelShadowRadius: CGFloat = 2
        
        /// How transparent the label shadows are (0.0 = invisible, 1.0 = solid)
        static let labelShadowOpacity: Double = 0.8
        
        /// How far the label shadows are offset (in pixels)
        static let labelShadowOffset: CGFloat = 1
        
        /// How blurry the needle shadow is when animating (in pixels)
        static let needleShadowRadius: CGFloat = 8
        
        /// How blurry the needle shadow is when not animating (in pixels)
        static let needleShadowRadiusInactive: CGFloat = 5
        
        /// How transparent the needle shadow is when animating (0.0 = invisible, 1.0 = solid)
        static let needleShadowOpacity: Double = 0.8
        
        /// How transparent the needle shadow is when not animating (0.0 = invisible, 1.0 = solid)
        static let needleShadowOpacityInactive: Double = 0.5
    }
    
    // MARK: - Scale Constants
    /// All the scaling values for animations
    /// These control how much elements grow or shrink during animations
    struct Scale {
        /// How much larger the needle gets when animating (1.0 = normal size)
        static let needleScaleActive: CGFloat = 1.05
        
        /// The normal size of the needle when not animating (1.0 = normal size)
        static let needleScaleInactive: CGFloat = 1.0
        
        /// How much larger the value display gets when animating (1.0 = normal size)
        static let valueDisplayScaleActive: CGFloat = 1.1
        
        /// The normal size of the value display when not animating (1.0 = normal size)
        static let valueDisplayScaleInactive: CGFloat = 1.0
        
        /// How much smaller the button gets when animating (1.0 = normal size)
        static let buttonScaleActive: CGFloat = 0.95
        
        /// The normal size of the button when not animating (1.0 = normal size)
        static let buttonScaleInactive: CGFloat = 1.0
    }
    
    // MARK: - Font Constants
    /// All the text size values
    /// These control how big or small different text elements are
    struct Fonts {
        /// The size of caption text (like the "Frame" label)
        static let captionSize: CGFloat = 14
        
        /// The size of the main value display text (the big number in the center)
        static let valueDisplaySize: CGFloat = 36
        
        /// The size of the scale label text (the numbers around the dial)
        static let scaleLabelSize: CGFloat = 14
    }
}
