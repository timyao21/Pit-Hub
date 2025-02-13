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
        HStack {
            Text(position)
                .font(.title)
                .frame(width: 40, alignment: .leading)
                .foregroundColor(position == "1" ? .orange : position == "2" ? .gray : position == "3" ? .brown : .primary.opacity(0.8))
            
            VStack(alignment: .leading){
                Text("\(constructor?.name ?? "N/A")")
                    .font(.headline)
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
                    .frame(width: 50, alignment: .trailing)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
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
            Text(constructor.nationality)
                .font(.caption)
                .foregroundColor(.secondary)
                .bold()
        }
        .padding(4)
        .background(Color(.systemGray6))
        .cornerRadius(5)
    }
}


