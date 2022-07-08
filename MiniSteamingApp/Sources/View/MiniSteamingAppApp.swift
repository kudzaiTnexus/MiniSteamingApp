//
//  MiniSteamingApp.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import SwiftUI

@main
struct MiniSteamingApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    let netWorkService = NetworkServiceImplementation()
                    let epgService = EPGServiceImplementation(service: netWorkService)
                    EventsView(viewModel: EPGViewModel(service: epgService))
                    .navigationTitle(L10n.events)
                    .accessibilityIdentifier("eventsView")
                }
                .tabItem {
                    Label(L10n.events, systemImage: "list.dash")
                }
                .tag(1)
                
                NavigationView {
                    let netWorkService = NetworkServiceImplementation()
                    let epgService = EPGServiceImplementation(service: netWorkService)
                    ScheduleView(viewModel: EPGViewModel(service: epgService))
                        .navigationTitle(L10n.schedule)
                        .accessibilityIdentifier("scheduleView")
                }
                .tabItem {
                    Label(L10n.schedule, systemImage: "square.and.pencil")
                }
                .tag(2)
            }
            .preferredColorScheme(.dark)
        }
    }
}
