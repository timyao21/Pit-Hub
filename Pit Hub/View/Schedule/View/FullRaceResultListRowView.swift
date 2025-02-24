//
//  FullRaceResultListRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/23/25.
//

import SwiftUI

// MARK: - Row view
struct FullRaceResultListRowView: View {
    
    let number: String
    let position: String
    let driverFirstName: String
    let driverLastName: String
    let points: String
    let status: String?
    let grid: String?
    let constructor: Constructor?
    
    private var positionColor: Color {
        switch position {
        case "1": return .orange
        case "2": return .gray
        case "3": return .brown
        default:  return .primary.opacity(0.8)
        }
    }

    private var constructorColor: Color {
        GetConstructorColor(constructorId: constructor?.constructorId ?? "")
    }

    private var gridValues: (gridString: String, gridInt: Int, posInt: Int)? {
        guard let grid = grid,
              let gridInt = Int(grid),
              let posInt = Int(position) else { return nil }
        return (grid, gridInt, posInt)
    }

    var body: some View {
        HStack (alignment: .center){
            Text(position)
                .font(.title)
                .frame(width: 40, alignment: .center)
                .foregroundColor(positionColor)
            
            // Driver info gets higher priority for available space.
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Text("\(driverFirstName) \(driverLastName)")
                        .font(.headline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text("\(number)")
                        .font(.custom(S.orbitron, size: 18))
                        .bold()
                        .foregroundColor(constructorColor)
                        .frame(width: 35)
                }
                
                if let gridValues = gridValues {
                    HStack(spacing: 3) {
                        GridDiffView(start: gridValues.gridInt, finish: gridValues.posInt)
                        Text("Start: \(gridValues.gridString)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .frame(height: 20)
                }
            }
            .layoutPriority(1)
            
            // Constructor tag and points now use only the space they need.
            VStack(alignment: .trailing) {
                if let constructor = constructor {
                    DriverConstructorTag(constructor: constructor)
                }
                Text("+ \(points) pts")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct GridDiffView: View {
    let start: Int
    let finish: Int

    var body: some View {
        // Calculate the difference
        let diff = start - finish
        
        HStack(spacing: 3) {
            if diff == 0 {
                Text("--")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                // Choose arrow based on whether diff is negative or positive.
                // Negative diff -> arrow down, Positive diff -> arrow up.
                Image(systemName: diff < 0 ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.secondary)
                
                // Optionally display the absolute difference value
                Text(String(abs(diff)))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 30)
    }
}
