//
//  ViewCurrentState.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import Foundation

/// View states
public enum ViewCurrentState {
    case loading
    case ready
    case failure(Error)

    public static func == (lhs: ViewCurrentState, rhs: ViewCurrentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
            (.ready, .ready),
            (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
