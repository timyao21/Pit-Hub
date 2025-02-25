//
//  ConstructorStandingsRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/13/25.
//

import SwiftUI

struct ConstructorStandingsRowView: View {
    let position: String
    let constructor : ConstructorTeam?
    let pointsDiff: String
    let points: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(position)
                .font(.title)
                .bold()
                .frame(width: 40, alignment: .leading)
                .foregroundColor(PositionColor(position: position).color)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(NSLocalizedString("\(constructor?.name ?? "N/A")", comment: "Constructor Name"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let constructor = constructor {
                    ConstructorNationalityTag(constructor: constructor)
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
                    .fontWeight(.semibold)
                    .frame(width: 50, alignment: .trailing)
                
            }
            
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.primary)
            
        }
        .padding(.vertical, 3)
        .padding(.horizontal)
    }
}

struct ConstructorNationalityTag: View {
    let constructor: ConstructorTeam
    
    var body: some View {
        HStack(spacing: 2) {
            // Display flag emoji
            Text(CountryFlags.flag(for: constructor.nationality))
                .font(.system(size: 16))
            
            // Display nationality text
            Text(NSLocalizedString(constructor.nationality, comment: "nationality Name"))
                .font(.caption)
                .foregroundColor(.white)
                .bold()
        }
        .padding(4)
        .background(Color(GetConstructorColor(constructorId: constructor.constructorId)).opacity(0.8))
        .cornerRadius(5)
    }
}


