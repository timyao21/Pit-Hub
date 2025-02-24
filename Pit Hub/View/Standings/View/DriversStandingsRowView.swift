//
//  StandingsRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/19/25.
//

import SwiftUI

struct DriversStandingsRowView: View {
    let position: String
    let driverFirstName: String
    let driverLastName: String
    let pointsDiff: String
    let points: String
    let constructor : Constructor?
    
    private var rowHeight: CGFloat {
        switch position {
        case "1":
            return 55
        case "2":
            return 45
        case "3":
            return 35
        default:
            return 30
        }
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(position)
                .font(.title)
                .bold()
                .frame(width: 35, alignment: .leading)
                .foregroundColor(PositionColor(position: position).color)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("\(driverLastName)")
                    .font(.title3)
                    .fontWeight(.semibold)
                if let constructor = constructor {
                    DriverConstructorTag(constructor: constructor)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 2) {
                if pointsDiff == "0" {
                    Text("-")
                        .font(.caption)
                        .foregroundColor(.gray)
                }else {
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                    Text(pointsDiff)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text(points)
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(width: 45, alignment: .trailing)
            }
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 2)
        .padding(.horizontal)
    }
}



