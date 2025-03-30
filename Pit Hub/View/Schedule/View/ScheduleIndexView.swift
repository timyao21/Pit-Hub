//
//  ScheduleIndexView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/29/25.
//

import SwiftUI


struct ScheduleIndexView: View {
    // State to trigger the sheet
    @Environment(IndexViewModel.self) private var viewModel
    @State private var sheetItem: Bool = true
    @State private var selectedDetent: PresentationDetent = .medium
    
    var body: some View {
        VStack {
            RaceCalendarView(viewModel: viewModel)
            Button("Button") {
                sheetItem.toggle()
            }
        }
        .sheet(isPresented: $sheetItem) {
            Text("Calendar")
                .font(.title)
                .padding()
                .presentationDetents(
                    [ .fraction(0.10), .medium, .large ],
                    selection: $selectedDetent
                )
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled(true)
        }
    }
}

//#Preview {
//    ScheduleIndexView()
//}
