//
//  ScheduleAsset.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation

typealias ScheduleAssets = [ScheduleAsset]

struct ScheduleAsset: Codable {
    let id, title, subtitle, date: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, date
        case imageURL = "imageUrl"
    }
}


