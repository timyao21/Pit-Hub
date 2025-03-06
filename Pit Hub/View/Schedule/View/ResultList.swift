//
//  ResultList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/22/25.
//

import SwiftUI

struct ResultList<T: RaceResults>: View {
    let length: Int
    let results: [T]?
    
    init(length: Int, results: [T]?) {
        self.length = length
        if let results = results {
            // Use the minimum of the provided length and the count of results.
            let count = min(length, results.count)
            // Convert the ArraySlice to a regular Array.
            self.results = Array(results[0..<count])
        } else {
            self.results = nil
        }
    }
    
    var body: some View {
        if let results = results {
            let halfIndex = results.count / 2
            
            VStack{
                if results.isEmpty {
                    DataErrorView()
                }else{
                    HStack(alignment: .top, spacing: 10) { // Create two columns with spacing
                        VStack(alignment: .leading, spacing: 2) {
                            ForEach(results.prefix(halfIndex).indices, id: \.self) { index in
                                ResultListRow(result: results[index])
                            }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            ForEach(results.suffix(from: halfIndex).indices, id: \.self) { index in
                                ResultListRow(result: results[index])
                            }
                        }
                    }
                }
            }
            .padding(.top)
        } else {
            Text("No Results")
        }
    }
}

struct ResultListRow<T: RaceResults>: View {
    let result: T
    var body: some View {
        HStack(alignment: .center) {
            Text(result.position)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(PositionColor(position: result.position).color)
                .frame(width: 20, alignment: .leading)
            
            Text(result.driver.code ?? result.driver.familyName)
                .font(.callout)
                .fontWeight(.semibold)
//                .foregroundColor(GetConstructorColor(constructorId: result.constructor?.constructorId ?? ""))
                .foregroundColor(Color.constructorColor(for: result.constructor?.constructorId ?? ""))
//
            
            if let constructor = result.constructor {
                DriverConstructorTag(constructor: constructor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 33)
    }
}
