//
//  NewUnercutAndOvercutView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/6/25.
//

import SwiftUI

struct NewUnercutAndOvercutView: View {
    @State var selectedTab: Int = 0
    let tabs = ["Normal", "Unercut", "Overcut"]
    var body: some View {
        VStack {
            SubTabSelector(selectedTab: $selectedTab, tabTitles: tabs)
            TabView(selection: $selectedTab) {
                Text("Normal")
                    .tag(0)
                Text("Unercut")
                    .tag(1)
                Text("Overcut")
                    .tag(2)
            }
        }
        .navigationTitle(Text("New Unercut and Overcut"))
    }
}

#Preview {
    NewUnercutAndOvercutView()
}
