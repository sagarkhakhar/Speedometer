/*
 * ARC SHAPE - THE CIRCULAR DRAWING TOOL
 * =====================================
 * 
 * This file contains a custom shape that can draw arcs (parts of circles).
 * Think of this as a "drawing tool" that helps us create the circular
 * elements of our speedometer.
 * 
 * WHAT THIS FILE DOES:
 * - Creates arcs (curved lines) for the speedometer dial
 * - Draws the progress arc that fills as the speed increases
 * - Provides a reusable way to create circular elements
 * - Handles the mathematical calculations for drawing arcs
 * 
 * THINK OF IT LIKE THIS:
 * - If you were drawing a speedometer by hand, you'd use a compass to draw circles
 * - This is like a digital compass that can draw parts of circles (arcs)
 * - It's used to create the curved progress bar and background arcs
 * 
 * WHY WE HAVE THIS:
 * - SwiftUI doesn't have a built-in arc shape
 * - We need arcs for the speedometer's circular progress indicator
 * - It makes the code more reusable and maintainable
 * - It handles the complex math of drawing arcs automatically
 * 
 * TECHNICAL DETAILS:
 * - Uses SwiftUI's Shape protocol
 * - Calculates arc paths using mathematical formulas
 * - Supports different start and end angles
 * - Can draw clockwise or counter-clockwise
 */

//
//  ArcShape.swift
//  Speedometer
//  
//  Created by Sagar Khakhar on 06/08/25.
//

import SwiftUI

/// A custom shape that draws an arc (part of a circle)
/// This is like a digital compass that can draw curved lines
struct ArcShape: Shape {
    /// The starting angle of the arc (where the arc begins)
    let startAngle: Angle
    
    /// The ending angle of the arc (where the arc ends)
    let endAngle: Angle
    
    /// Whether to draw the arc clockwise or counter-clockwise
    /// true = clockwise, false = counter-clockwise
    let clockwise: Bool
    
    /// This function defines how to draw the arc
    /// SwiftUI calls this function when it needs to render the shape
    /// - Parameter rect: The rectangle where the arc should be drawn
    /// - Returns: A Path object that describes the arc
    func path(in rect: CGRect) -> Path {
        // Calculate the center point of the rectangle
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        // Calculate the radius (half the width of the rectangle)
        let radius = rect.width / 2.0
        
        // Create and return a Path that describes our arc
        return Path { path in
            // Add an arc to the path
            path.addArc(
                center: center,        // The center point of the arc
                radius: radius,        // How far from center the arc should be
                startAngle: startAngle, // Where the arc starts
                endAngle: endAngle,     // Where the arc ends
                clockwise: clockwise    // Which direction to draw
            )
        }
    }
}
