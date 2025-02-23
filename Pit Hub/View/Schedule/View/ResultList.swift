//
//  ResultList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/22/25.
//

import SwiftUI

struct ResultList: View {
    let length: Int
    let results: [Results]?
    
    init(length: Int, results: [Results]?) {
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
            
            HStack(alignment: .top, spacing: 20) { // Create two columns with spacing
                VStack(alignment: .leading) {
                    ForEach(results.prefix(halfIndex).indices, id: \.self) { index in
                        ResultListRow(result: results[index])
                    }
                }
                
                Divider()
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    ForEach(results.suffix(from: halfIndex).indices, id: \.self) { index in
                        ResultListRow(result: results[index])
                    }
                }
            }
            .padding(.vertical)
        } else {
            Text("No Results")
        }
    }
}

struct ResultListRow: View {
    let result: Results
    var body: some View {
        HStack{
            Text(result.position)
                .font(.headline)
                .foregroundColor(.primary)
                .frame(width: 20, alignment: .leading)
            Text(result.driver.code ?? "N/A")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .frame(minWidth: 20, maxWidth: .infinity, alignment: .leading)
            if let constructor = result.constructor {
                DriverConstructorTag(constructor: constructor)
                    .frame(minWidth: 100, maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 30)
    }
}
