//
//  ScheduleView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        ScheduleList(scheduleManager: ScheduleManager(year: 2023))
    }
}

#Preview {
    ScheduleView()
}
