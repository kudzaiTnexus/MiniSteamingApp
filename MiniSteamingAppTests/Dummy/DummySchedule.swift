//
//  DummySchedule.swift
//  MiniSteamingAppTests
//
//  Created by KudzaisheMhou on 08/07/2022.
//
@testable import MiniSteamingApp
import Foundation

class DummySchedule {
    static func dummyData() -> ScheduleAssets {
        return [
            Schedule(
                id: "test-id-1",
                title: "Test-Title-1",
                subtitle: "Test-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                date: "2022-07-08T10:19:11.565Z"
            ),
            Schedule(
                id: "test-id-2",
                title: "Test-Title-2",
                subtitle: "Test-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                date: "2022-07-09T10:19:11.565Z"
            ),
            Schedule(
                id: "test-id-3",
                title: "Test-Title-3",
                subtitle: "Test-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                date: "2022-02-08T10:19:11.565Z"
            ),
            Schedule(
                id: "test-id-4",
                title: "Test-Title-4",
                subtitle: "Test-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                date: "2022-06-08T10:19:11.565Z"
            ),
            Schedule(
                id: "test-id-5",
                title: "Test-Title-5",
                subtitle: "Test-SubTitle-1",
                imageURL: "http://www.designbolts.com/wp-content/uploads/2017/04/paris-iPhone-7-Wallpaper-HD.jpg",
                date: "2022-08-08T10:19:11.565Z"
            )
        ]
    }
}
