//
//  CustomPageIndicator.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/12/25.
//

import SwiftUI

struct CustomPageIndicator: View {
    @Binding var selectedTab: Int
    let numberOfPages: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == selectedTab ? Color(S.pitHubIconColor) : Color.secondary.opacity(0.5))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 8)
    }
}
