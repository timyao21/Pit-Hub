//
//  DriverNicknameViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/9/25.
//

import Foundation

@Observable class DriverNicknameViewModel{
    
    private let driverManager = DriverStandingsManager()
    
    @MainActor var drivers: [Driver] = []
    @MainActor var selectedDriverId: String = ""

    @MainActor
    func fetchAllDrivers() async {
        let curYear = Calendar.current.component(.year, from: Date())
        Task {
            try await drivers = driverManager.fetchDrivers(for: "\(curYear)")
        }
    }
    
}

