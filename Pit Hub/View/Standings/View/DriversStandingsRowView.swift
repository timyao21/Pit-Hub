//
//  StandingsRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/19/25.
//

import SwiftUI
import SwiftData

struct DriversStandingsRowView: View {
    @Query(sort: \DriverNickname.driverId) var driverNickname: [DriverNickname]
    
    let driverId: String
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
                .frame(width: 40, alignment: .center)
                .foregroundColor(PositionColor(position: position).color)
            
            VStack(alignment: .leading, spacing: 3) {
                
                if let nickname = driverNickname.first(where: { $0.driverId == driverId })?.nickname,
                   !nickname.isEmpty {
                    HStack(alignment: .bottom, spacing: 3){
                        Text(nickname)
                            .font(.headline)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Group{
                            Text("(")
                            Text(LocalizedStringKey(driverLastName))
                            Text(")")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                } else{
                    HStack(spacing: 2) {
                        Text(LocalizedStringKey(driverFirstName))
                        Text("·")
                        Text(LocalizedStringKey(driverLastName))
                    }
                    .font(.headline)
                    .font(.title3)
                    .fontWeight(.semibold)
                }
                
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



