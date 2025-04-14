//
//  UnderOverCutView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/30/25.
//

import SwiftUI

struct CircularCircuitView: View {
    @State var viewModel = CircularCircuitViewModels()
    
    init() {
        
    }
    
    init(redPitLap: CGFloat, redPitStopTime: CGFloat, redSpeedChangeLap: CGFloat, redSpeedNew: CGFloat, bluePitLap: CGFloat, bluePitStopTime: CGFloat, blueSpeedChangeLap: CGFloat, blueSpeedNew: CGFloat){
        
        viewModel.redPitLap = redPitLap
        viewModel.redPitStopTime = redPitStopTime
        viewModel.redSpeedChangeLap = redSpeedChangeLap
        viewModel.redSpeedNew = redSpeedNew
        
        viewModel.bluePitLap = bluePitLap
        viewModel.bluePitStopTime = bluePitStopTime
        viewModel.blueSpeedChangeLap = blueSpeedChangeLap
        viewModel.blueSpeedNew = blueSpeedNew
        
    }
    
    var body: some View {
        VStack {
            ZStack{
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
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                    .position(viewModel.racetrackPointForLapProgress(viewModel.redLapProgress))

                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .position(viewModel.racetrackPointForLapProgress(viewModel.blueLapProgress))
                HStack(alignment: .bottom){
                    Text("Speed:")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.primary)
                        
                    SpeedIndicatorView(speed: viewModel.redSpeed, color: .red)
                    SpeedIndicatorView(speed: viewModel.blueSpeed, color: .blue)
                }
                
            }
            .frame(width: 300, height: 150)
            
            // Play and Reset buttons
            HStack {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.prepare()
                    
                    if viewModel.isRunning {
                        viewModel.stopTimer()
                    } else {
                        viewModel.startTimer()
                    }
                    
                    generator.impactOccurred()
                }) {
                    Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                        .tint(Color(S.pitHubIconColor))
                }
                
                // Slider to control overall progress
                Slider(value: $viewModel.progress, in: 0...1)
                    .tint(Color(S.pitHubIconColor))
                    .padding()

            }
        }
        .frame(width: 350)
        .environment(viewModel)
    }
}

struct SpeedIndicatorView: View {
    let speed: CGFloat
    let color: Color
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 30, height: CGFloat((speed-0.99) * 80) * 5)
            Text("\(String(format: "%.2f", speed))x")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color)
        }
        .frame(height: 60, alignment: .bottom)
    }
}

#Preview {
    CircularCircuitView(redPitLap: 2, redPitStopTime: 0.5, redSpeedChangeLap: 1, redSpeedNew: 1.08, bluePitLap: 1, bluePitStopTime: 0.5, blueSpeedChangeLap: 1, blueSpeedNew: 1.04)
}
