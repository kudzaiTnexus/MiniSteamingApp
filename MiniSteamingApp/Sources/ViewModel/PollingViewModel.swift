//
//  TimerViewModel.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import Foundation
import Combine

class PollingViewModel {
    
    public var timer: Timer.TimerPublisher!
    
    private var interval: TimeInterval
    private var cancellableTimer: Cancellable?
    
    init(interval: TimeInterval = 30.0) {
        self.interval = interval
        self.timer = Timer.publish(every: interval, on: .current, in: .common)
    }

    public func beginPolling() {
        cancellableTimer = timer.connect()
    }

    public func stopPolling() {
        guard let currentTimer = cancellableTimer else {
            return
        }

        currentTimer.cancel()
        timer = Timer.publish(every: interval, on: .current, in: .common)
    }
}
