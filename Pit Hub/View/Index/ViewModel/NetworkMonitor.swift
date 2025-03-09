//
//  NetworkMonitor.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/8/25.
//

import Foundation
import Network

@Observable class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @MainActor var isActive = false
    @MainActor var isExpensive = false
    @MainActor var isConstrained = false
    @MainActor var connectionType = NWInterface.InterfaceType.other
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                self.isExpensive = path.isExpensive
                self.isConstrained = path.isConstrained
                
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        monitor.start(queue: queue)
    }
}
