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
    
    var body: some View {
        VStack {
            Text("\(results1.first?.year ?? " ") - \(results1.first?.driverName ?? " ")")
            Chart {
                ForEach(results1) { result in
                    if let roundNumber = Int(result.round),
                       let positionNumber = Int(result.position) {
                        // Draw a line connecting each round's finishing position
                        let adjustedPosition = 21 - positionNumber
                        LineMark(
                            x: .value("Round", roundNumber),
                            y: .value("Position", adjustedPosition)
                        )
                        // Mark each data point for clarity
                        PointMark(
                            x: .value("Round", roundNumber),
                            y: .value("Position", adjustedPosition)
                        )
                    }
                }
            }
            // Optionally customize the x and y axes:
            .chartYScale(domain: 1...20)
            .chartXAxis {
                AxisMarks(values: .automatic)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .frame(height: 320)
        .cornerRadius(20)

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

