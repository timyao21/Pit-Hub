//
//  ScheduleViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/17/24.
//

import Foundation
import MapKit

extension ScheduleList {
    @Observable
    class ViewModel {  // Renamed to PascalCase
        var pastMeetings = [Meeting]()
    }
}
