//
//  YearDropdownSelector.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import SwiftUI

struct YearDropdownSelector: View {
    @Binding var selectedYear: String
    var onYearChange: (String) -> Void // Closure to call different functions

    private let availableYears: [String] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return [String(currentYear), String(currentYear - 1)]
    }()

    var body: some View {
        Menu {
            ForEach(availableYears, id: \.self) { year in
                Button(action: {
                    if selectedYear != year { // Only update if the year is different
                        selectedYear = year
                        onYearChange(year) // Call the passed function
                    }
                }) {
                    Text(year)
                }
            }
        } label: {
            HStack {
                Text(selectedYear)
                    .font(.custom(S.smileySans, size: 18))
            }
            .foregroundStyle(Color(S.pitHubIconColor))
            .padding(3)
        }
    }
}


