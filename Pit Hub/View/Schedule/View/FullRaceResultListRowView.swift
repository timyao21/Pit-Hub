//
//  FullRaceResultListRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/23/25.
//

import SwiftUI
import SwiftData

struct FullRaceResultListRowView: View {
    
    let driverId: String
    let number: String
    let position: String?
    let positionText: String
    let driverFirstName: String
    let driverLastName: String
    let points: String
    let status: String?
    let grid: String?
    let constructor: Constructor?

//    get the grid info
    private var gridValues: (gridString: String, gridInt: Int, posInt: Int)? {
        guard let grid = grid,
              let gridInt = Int(grid),
              let posInt = Int(position ?? "0") else { return nil }
        return (grid, gridInt, posInt)
    }

    var body: some View {
        HStack (alignment: .center){
//            position
            Text(positionText)
                .frame(width: 40, alignment: .center)
                .font(.title)
                .bold()
                .foregroundColor(PositionColor(position: position ?? "5").color)
            
//            Driver info gets higher priority for available space.
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
//                    Drivers Name
                    DriverLastName(id: driverId, driverLastName: driverLastName)

                    Text("\(number)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.constructorColor(for: constructor?.constructorId ?? ""))
                        .frame(width: 35)
                }
                
                if let gridValues = gridValues {
                    HStack(spacing: 3) {
                        GridDiffView(start: gridValues.gridInt, finish: gridValues.posInt)
                        Text("Start: \(gridValues.gridString)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Constructor tag and points now use only the space they need.
            VStack(alignment: .trailing) {
                if let constructor = constructor {
                    DriverConstructorTag(constructor: constructor)
                }
                Text("+ \(points) pts")
                    .font(.body)
                    .fontWeight(.semibold)
            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

private struct GridDiffView: View {
    let start: Int
    let finish: Int

    var body: some View {
        // Calculate the difference
        let diff = start - finish
        
        HStack(alignment: .center, spacing: 3) {
            if diff == 0 {
                Text("--")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else {
                // Choose arrow based on whether diff is negative or positive.
                // Negative diff -> arrow down, Positive diff -> arrow up.
                Image(systemName: diff < 0 ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 7, height: 7)
                    .foregroundColor(diff < 0 ? .red : .green)
                
                // Optionally display the absolute difference value
                Text(String(abs(diff)))
                    .font(.footnote)
                    .foregroundColor(diff < 0 ? .red : .green)
            }
        }
        .frame(width: 40, height: 10)
    }
}

// MARK: - Public Components
struct DriverLastName: View {
    
    //    Get the nickname from SwiftData
    @Query(sort: \DriverNickname.driverId) var driverNickname: [DriverNickname]
    
    let id: String
    let driverLastName: String
    
    //    Display Driver's Lastname
    private var driverLastNameDisplay: String {
        if let nickname = driverNickname.first(where: { $0.driverId == id })?.nickname,
           !nickname.isEmpty{
            return nickname
        }else{
            return ""
        }
    }
    
    var body: some View {
        if driverLastNameDisplay.isEmpty {
            Text(LocalizedStringKey(driverLastName))
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(1)
        }else{
            HStack(alignment: .bottom){
                Text(LocalizedStringKey(driverLastNameDisplay))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Group{
                    Text("(")
                    Text(LocalizedStringKey(driverLastName))
                    Text(")")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            }
        }
    }
}
