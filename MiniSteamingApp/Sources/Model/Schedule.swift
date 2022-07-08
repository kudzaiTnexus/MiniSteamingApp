//
//  Schedule.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation

typealias ScheduleAssets = [Schedule]

struct Schedule: Codable {
    
    let id, title, subtitle: String
    let imageURL: String
    
    private let date: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, date
        case imageURL = "imageUrl"
    }
    
    internal init(
        id: String,
        title: String,
        subtitle: String,
        imageURL: String,
        date: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.date = date
    }
}

extension Schedule: Video {
    var startDate: Date? {
        DateFormatter.date(fromDAZNString: date)
    }
}

