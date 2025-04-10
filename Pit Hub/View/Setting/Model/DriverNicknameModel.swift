//
//  DriverNicknameModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/9/25.
//

import Foundation
import SwiftData

@Model
class DriverNickname{
    @Attribute(.unique) var driverId: String
    var driver: Driver
    var nickname: String
    
    init(driverId: String, driver: Driver, nickname: String) {
        self.driverId = driverId
        self.driver = driver
        self.nickname = nickname
    }
}
