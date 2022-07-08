//
//  Video.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation

protocol Video: Identifiable {
    var id: String { get }
    var title: String { get }
    var subtitle: String { get }
    var startDate: Date? { get }
    var imageURL: String { get }
}
