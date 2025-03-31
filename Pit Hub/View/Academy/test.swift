//
//  test.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/30/25.
//

//import SwiftUI
//
//struct test: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

import SwiftUI

struct test: View {
    @State private var progress: CGFloat = 0.0  // Overall progress (0.0 to 1.0)

    // Configuration
    let laps: CGFloat = 5
    let frontOffset: CGFloat = 0.05
    @State private var redSpeed: CGFloat = 1.0
    @State private var blueSpeed: CGFloat = 1.0
    // Pit stop configuration for the red dot at lap 2:
    // pitStopFraction is the extra fraction of a lap that represents the pit stop delay.
    @State private var redPitStopFraction: CGFloat = 0.5
    @State private var bluePitStopFraction: CGFloat = 0.5

    /// Computed red dot lap progress with a pit stop at lap 2.
    var redLapProgress: CGFloat {
        var redAbsolute = progress * redSpeed * laps
        var effectiveRedAbsolute = redAbsolute
        if redAbsolute >= 2 && redAbsolute < 2 + redPitStopFraction {
            // Stall the red dot at lap 2 (i.e. at the start/finish)
            effectiveRedAbsolute = 2
        } else if redAbsolute >= 2 + redPitStopFraction {
            // After the pit stop, subtract the delay so the lap progress remains continuous.
            effectiveRedAbsolute = redAbsolute - redPitStopFraction
            self.redSpeed += 0.1
        }
        return effectiveRedAbsolute.truncatingRemainder(dividingBy: 1)
    }
    
    /// Computed blue dot lap progress (no pit stop, with an offset).
    var blueLapProgress: CGFloat {
        let blueAbsolute = ((progress * blueSpeed) * laps) + frontOffset
        var effectiveBlueAbsolute = blueAbsolute
        
        if blueAbsolute >= 2 && blueAbsolute < 2 + bluePitStopFraction {
            // Stall the red dot at lap 2 (i.e. at the start/finish)
            effectiveBlueAbsolute = 2
        } else if blueAbsolute >= 2 + bluePitStopFraction {
            // After the pit stop, subtract the delay so the lap progress remains continuous.
            effectiveBlueAbsolute = blueAbsolute - bluePitStopFraction
        }
        return effectiveBlueAbsolute.truncatingRemainder(dividingBy: 1)
    }

    var body: some View {
        VStack {
            ZStack {
                // Draw the racetrack shape.
                Path { path in
                    path.move(to: CGPoint(x: 75, y: 0))
                    path.addLine(to: CGPoint(x: 225, y: 0))
                    path.addArc(center: CGPoint(x: 225, y: 75),
                                radius: 75,
                                startAngle: Angle(degrees: -90),
                                endAngle: Angle(degrees: 90),
                                clockwise: false)
                    path.addLine(to: CGPoint(x: 75, y: 150))
                    path.addArc(center: CGPoint(x: 75, y: 75),
                                radius: 75,
                                startAngle: Angle(degrees: 90),
                                endAngle: Angle(degrees: 270),
                                clockwise: false)
                    path.closeSubpath()
                }
                .stroke(Color.gray, lineWidth: 6)
                
                // Draw the start line as a vertical dashed line along the left edge.
                Path { path in
                    path.move(to: CGPoint(x: 75, y: -15))
                    path.addLine(to: CGPoint(x: 75, y: 15))
                }
                .stroke(Color.black, style: StrokeStyle(lineWidth: 2, dash: [3]))
                
                // Red dot (with pit stop at lap 2)
                Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                    .position(racetrackPointForLapProgress(redLapProgress))
                
                // Blue dot (no pit stop)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .position(racetrackPointForLapProgress(blueLapProgress))
            }
            .frame(width: 300, height: 150)

            
            // Slider to control overall progress
            Slider(value: $progress, in: 0...1)
                .tint(Color(S.pitHubIconColor))
                .padding()
        }
        // Update redSpeed when progress changes and the red dot has passed its pit stop window.
        .onChange(of: progress) { newProgress in
            let redAbsolute = newProgress * redSpeed * laps
            if redAbsolute >= 2 + redPitStopFraction {
                redSpeed = 1.00
            }
        }
    }
    
    /// Computes the position along one lap of the racetrack for a given normalized lap progress (0...1).
    /// The track is composed of:
    /// - Top straight (from (75,0) to (225,0)): 150 points.
    /// - Right arc (center (225,75), radius 75): length π×75.
    /// - Bottom straight (from (225,150) to (75,150)): 150 points.
    /// - Left arc (center (75,75), radius 75): length π×75.
    func racetrackPointForLapProgress(_ lapProgress: CGFloat) -> CGPoint {
        let r: CGFloat = 75
        let L1: CGFloat = 150                // Top straight
        let L2: CGFloat = .pi * r            // Right arc
        let L3: CGFloat = 150                // Bottom straight
        let L4: CGFloat = .pi * r            // Left arc
        let totalLength = L1 + L2 + L3 + L4    // Total perimeter
        let s = lapProgress * totalLength
        
        if s <= L1 {
            let x = 75 + s
            return CGPoint(x: x, y: 0)
        } else if s <= L1 + L2 {
            let u = (s - L1) / L2
            let startAngle = -CGFloat.pi / 2
            let angle = startAngle + u * CGFloat.pi
            let x = 225 + r * cos(angle)
            let y = 75 + r * sin(angle)
            return CGPoint(x: x, y: y)
        } else if s <= L1 + L2 + L3 {
            let u = (s - (L1 + L2)) / L3
            let x = 225 - u * 150
            return CGPoint(x: x, y: 150)
        } else {
            let u = (s - (L1 + L2 + L3)) / L4
            let startAngle = CGFloat.pi / 2
            let angle = startAngle + u * CGFloat.pi
            let x = 75 + r * cos(angle)
            let y = 75 + r * sin(angle)
            return CGPoint(x: x, y: y)
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
