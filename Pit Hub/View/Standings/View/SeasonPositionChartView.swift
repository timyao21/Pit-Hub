//
//  SeasonPositionChartView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/27/25.
//

import SwiftUI
import Charts

struct SeasonPositionChartView: View {
    let results1: [PositionChart]
    
    // Chart Size (I set to 25 just in case there are more drives in the feature)
    private let baseValue: Double = 25.0
    @State private var selectedData: PositionChart?
    
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
                if let data = selectedData{
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(LocalizedStringKey(data.circuitId ?? "Unknown Circuit"))
                                .frame(width: 40, alignment: .leading)
                            Text("Round: \(data.round)")
                        }
                        Text("Position: \(data.position)")
                    }
                    .font(.caption)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.blue.opacity(0.8))

                }else{
                    VStack(alignment: .leading, spacing: 4){
                        Text(LocalizedStringKey(results1.first?.driverName ?? "Driver"))
                        Text("Season Peformance (Positions)")
                    }
                    .font(.caption)
                    .lineLimit(2)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                Text("\(results1.first?.year ?? "Year")")
                    .font(.caption)
                    .padding(.bottom, 8)
            }
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .padding(.horizontal)
            
            // MARK: - make sure the data is sorted
            
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
                    .foregroundStyle(.gray)
                    .annotation(position: .bottom, alignment: .trailing) {
                        Text("Avg: \(String(format: "%.1f", averageRawPosition))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                if let selected = selectedData, let selectedRound = Int(selected.round) {
                    RuleMark(x: .value("Round", selectedRound))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                        .foregroundStyle(.blue)
                }
            }
            // Use baseValue to dynamically set the y-axis scale (1...baseValue-1)
            .chartYScale(domain: 1.0...(baseValue - 1.0))
            .chartXScale(domain: 1.0...Double(results1.count + 1))
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
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    // Convert the x-coordinate from the gesture into a round number.
                                    let location = value.location
                                    if let round: Int = proxy.value(atX: location.x) {
                                        // Find the first matching data point.
                                        if let matched = results1.first(where: { Int($0.round) == round }) {
                                            selectedData = matched
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    // Optionally, clear the selection when the drag ends.
                                    selectedData = nil
                                }
                        )
                }
            }
        }
        .aspectRatio(1.5,contentMode: .fit)
    }
}

struct SeasonChartView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = [
            PositionChart(year: "2023", driverName: "Hamilton", driverNumber: "44", round: "1", circuitId: "silverstone", position: "2"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "2", circuitId: "monza", position: "1"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "3", circuitId: "spa", position: "3"),
            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "4", circuitId: "interlagos", position: "4"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "5", circuitId: "hockenheim", position: "10"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "6", circuitId: "sakhir", position: "6"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "7", circuitId: "redbullring", position: "7"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "8", circuitId: "suzuka", position: "6"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "9", circuitId: "marinabay", position: "6"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "10", circuitId: "americas", position: "18"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "11", circuitId: "bahrain", position: "2"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "12", circuitId: "mexico", position: "1"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "13", circuitId: "italy", position: "9"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "14", circuitId: "austria", position: "10"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "15", circuitId: "hungaroring", position: "3"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "16", circuitId: "sochi", position: "4"),
//            PositionChart(year: "2023", driverName: "Lewis Hamilton", driverNumber: "44", round: "17", circuitId: "zandvoort", position: "1")
        ]

        

        SeasonPositionChartView(results1: sampleData)
        
    }
}

