//
//  FullQualifyingResultListRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/1/25.
//

import SwiftUI

struct FullQualifyingResultListRowView: View {
    
    let number: String
    let position: String
    let driverFirstName: String
    let driverLastName: String
    let timeDiff: String
    let lapTime: String
    let constructor : Constructor?
    
//    private var constructorColor: Color {
//        GetConstructorColor(constructorId: constructor?.constructorId ?? "")
//    }
    
    // Computed property to check if time difference should be hidden
    private var formattedTimeDiff: String {
        return (position == "16" || position == "11") ? "-" : timeDiff
    }
    
    var body: some View {
        HStack (alignment: .center){
            Text(position)
                .font(.title)
                .bold()
                .frame(width: 40, alignment: .center)
                .foregroundColor(PositionColor(position: position).color)

            // Driver info gets higher priority for available space.
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Text("\(NSLocalizedString(driverLastName, comment: "Driver's last name"))")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text("\(number)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.constructorColor(for: constructor?.constructorId ?? ""))
                        .frame(width: 35)
                }
                HStack {
                    Text(formattedTimeDiff)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("\(lapTime)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .layoutPriority(1)
            
            if let constructor = constructor {
                DriverConstructorTag(constructor: constructor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal)
    }
}
