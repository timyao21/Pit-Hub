//
//  ScheduleView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

//var selectedYear: Int? = 2024

struct ScheduleView: View {
    
    @State private var selectedYear: Int = 2024
    
    var body: some View {
        VStack{
            HStack{
                Menu() {
                    Button("2022") {
                        selectedYear = 2022
                    }
                    Button("2023") {
                        selectedYear = 2023
                    }
                    Button("2024") {
                        selectedYear = 2024
                    }
                    Button("2025") {
                        selectedYear = 2025
                    }
                }label: {
                    HStack {
                        Text(String(format: "%d F1 赛历", selectedYear))
                        Image(systemName: "arrowtriangle.down.fill")
                            .imageScale(.small)
                    }
                }
                    .font(.custom(S.smileySans, size: 30)) // Match the font of the Text
                    .padding(.leading, 16)
                    .foregroundColor(Color(S.pitHubIconColor))
                Spacer()
            }
            ScheduleList(scheduleManager: ScheduleManager(year: selectedYear))
                .id(selectedYear) // Ensures re-rendering
        }
    }
}

#Preview {
    ScheduleView()
}
