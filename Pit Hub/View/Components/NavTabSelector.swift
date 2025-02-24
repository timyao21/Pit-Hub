//
//  NavTabSelector.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import SwiftUI

struct NavTabSelector: View {
    @Binding var selectedTab: Int
    let tabTitles: [String]

    var body: some View {
        HStack(spacing: 10) {
            ForEach(tabTitles.indices, id: \.self) { index in
                tabButton(title: tabTitles[index], tab: index)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.2)) // Light background for contrast
        .clipShape(Capsule()) // Smooth rounded edges
    }

    private func tabButton(title: String, tab: Int) -> some View {
        Button(action: { selectedTab = tab }) {
            Text(NSLocalizedString(title, comment: "Localized title text"))
                .font(.custom(S.smileySans, size: 16))
                .foregroundColor(selectedTab == tab ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(selectedTab == tab ? Color(S.pitHubIconColor) : Color.clear)
                .clipShape(Capsule()) // Rounded button style
                .animation(.easeInOut(duration: 0.35), value: selectedTab)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button tap effect
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = 3

        var body: some View {
            NavTabSelector(selectedTab: $selectedTab, tabTitles: ["Driver", "Constructor", "Team"])
        }
    }
    
    return PreviewWrapper()
}

