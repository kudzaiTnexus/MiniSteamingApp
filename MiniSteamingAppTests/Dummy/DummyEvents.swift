//
//  DummyEvents.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 08/07/2022.
//

@testable import MiniSteamingApp
import Foundation

class DummyEvents {
    static func dummyData() -> Events {
        return [
            
            Event(
                id: "test-event-id-1",
                title: "Test-Event-Title-1",
                subtitle: "Test-Event-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                videoURL: "https://bit.ly/swswift",
                date: "2022-07-08T10:19:11.565Z"),
            
            Event(
                id: "test-event-id-1",
                title: "Test-Event-Title-1",
                subtitle: "Test-Event-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                videoURL: "https://bit.ly/swswift",
                date: "2022-09-08T10:22:11.565Z"),
            
            Event(
                id: "test-event-id-1",
                title: "Test-Event-Title-1",
                subtitle: "Test-Event-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                videoURL: "https://bit.ly/swswift",
                date: "2022-01-08T10:16:11.565Z"),
            
            Event(
                id: "test-event-id-1",
                title: "Test-Event-Title-1",
                subtitle: "Test-Event-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                videoURL: "https://bit.ly/swswift",
                date: "2022-02-08T10:11:11.565Z"),
            
            Event(
                id: "test-event-id-1",
                title: "Test-Event-Title-1",
                subtitle: "Test-Event-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                videoURL: "https://bit.ly/swswift",
                date: "2022-08-08T10:19:11.565Z")
            
        ]
    }
}
