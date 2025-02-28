//
//  SeasonPositionChartView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/27/25.
//

import SwiftUI
import Charts

struct SeasonChartView: View {
    let results1: [PositionChart]
    
    // Base value used to flip the chart (for example, if max position is 20, baseValue = 21)
    private let baseValue: Double = 25.0
    
    // Compute the average raw finishing position from the data
    var averageRawPosition: Double {
        let positions = results1.compactMap { Double($0.position) }
        guard !positions.isEmpty else { return 0 }
        return positions.reduce(0, +) / Double(positions.count)
    }
    
    // Adjust the average to match the chart’s scale (where 1st becomes highest)
    var adjustedAveragePosition: Double {
        baseValue - averageRawPosition
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(results1.first?.driverName ?? "Driver")")
                    .font(.caption)
                    .padding(.bottom, 8)
                Text("\(results1.first?.year ?? "Year")")
                    .font(.caption)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .padding(.horizontal)
            
            Chart {
                ForEach(results1) { result in
                    if let roundNumber = Int(result.round),
                       let positionNumber = Int(result.position) {
                        // Adjust the raw position to flip the chart using baseValue
                        let adjustedPosition = baseValue - Double(positionNumber)
                        LineMark(
                            x: .value("Round", roundNumber),
                            y: .value("Position", adjustedPosition)
                        )
                        .foregroundStyle(Color(S.pitHubIconColor))
                        
                        PointMark(
                            x: .value("Round", roundNumber),
                            y: .value("Position", adjustedPosition)
                        )
                        .foregroundStyle(Color(S.pitHubIconColor))
                    }
                }
                // Display a rule mark at the adjusted average position with a label.
                RuleMark(y: .value("Average Position", adjustedAveragePosition))
                    .foregroundStyle(.blue)
                    .annotation(position: .bottom, alignment: .trailing) {
                        Text("Avg: \(String(format: "%.1f", averageRawPosition))")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
            }
            // Use baseValue to dynamically set the y-axis scale (1...baseValue-1)
            .chartYScale(domain: 1.0...(baseValue - 1.0))
            .chartXAxis {
                AxisMarks(values: .automatic)
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    if let adjustedValue = value.as(Double.self) {
                        // Convert adjusted value back to the original finishing position.
                        let label = Int(baseValue - adjustedValue)
                        AxisValueLabel("\(label)")
                    }
                }
            }
        }
        .padding()
//        .background(Color.gray.opacity(0.1))
        .frame(height: 188)
//        .cornerRadius(20)
    }
}

struct SeasonChartView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = [
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "1", position: "2"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "2", position: "1"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "3", position: "3"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "4", position: "4"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "5", position: "10"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "6", position: "6"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "7", position: "7"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "8", position: "6"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "9", position: "6"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "10", position: "18"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "11", position: "2"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "12", position: "1"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "13", position: "9"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "14", position: "10"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "15", position: "3"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "16", position: "4"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "17", position: "1")
        ]
        

            SeasonChartView(results1: sampleData)
        
    }
}

