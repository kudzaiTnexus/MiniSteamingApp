//
//  Video.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation
import Combine

typealias Events = [Event]

struct Event: Codable {
    
    let id, title, subtitle: String
    let imageURL: String
    let videoURL: String
    
    private let date: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, date
        case imageURL = "imageUrl"
        case videoURL = "videoUrl"
    }
    
    internal init(
        id: String,
        title: String,
        subtitle: String,
        imageURL: String,
        videoURL: String,
        date: String
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.date = date
    }
}

extension Event: Video {
    var startDate: Date? {
        DateFormatter.date(fromDAZNString: date)
    }
}
