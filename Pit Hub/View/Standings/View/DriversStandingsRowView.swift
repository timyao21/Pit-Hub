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
    
    var body: some View {
        HStack {
            Text(position)
                .font(.title)
                .frame(width: 40, alignment: .leading)
                .foregroundColor(position == "1" ? .orange : position == "2" ? .gray : position == "3" ? .brown : .primary.opacity(0.8))
            
            VStack(alignment: .leading){
                Text("\(driverFirstName) \(driverLastName)")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let constructor = constructor {
                    DriverConstructorTag(constructor: constructor)
                }
            }
            
            HStack(spacing: 3) {
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
                    .frame(width: 50, alignment: .trailing)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct DriverConstructorTag: View {
    let constructor: Constructor
    
    var body: some View {
        Text(constructor.name)
            .font(.caption)
            .foregroundStyle(.white)
            .bold()
            .padding(4)
            .background(Color("\(constructor.constructorId)").opacity(0.9))
            .cornerRadius(5)
    }
}

