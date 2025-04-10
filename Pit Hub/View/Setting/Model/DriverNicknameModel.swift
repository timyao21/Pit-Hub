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
    var nickname: String
    
    init(driverId: String, nickname: String) {
        self.driverId = driverId
        self.nickname = nickname
    }
}
