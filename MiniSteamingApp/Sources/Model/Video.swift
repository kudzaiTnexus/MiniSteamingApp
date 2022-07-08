//
//  Video.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation

typealias Videos = [Video]

// MARK: - Video
struct Video: Codable {
    let id, title, subtitle, date: String
    let imageURL: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, date
        case imageURL = "imageUrl"
        case videoURL = "videoUrl"
    }
}

