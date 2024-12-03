//
//  NetworkMonitor.swift
//  FirebaseChatApp
//
//  Created by Amisha Italiya on 29/11/24.
//

import Foundation
import Network

public class NetworkMonitor: ObservableObject {

    private var monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)

    @Published public var isConnected: Bool = true

    public init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
