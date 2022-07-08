//
//  EPGViewModel.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import Foundation
import Combine

@MainActor
public class EPGViewModel: ObservableObject {
    
    private let service: EPGService
    private(set) var events: Events = []
    private(set) var schedule: ScheduleAssets = []
    private var cancellable = Set<AnyCancellable>()
    
    @Published private(set) var viewState: ViewCurrentState = .loading
    
    init(service: EPGService) {
        self.service = service
    }
    
    func getEvents() {
        self.viewState = .loading
        service
            .events()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    guard let self = `self` else {  return }
                    self.events = self.ascendingOrder(items: response)
                    self.viewState = .ready
                case .failure(let error):
                    self?.viewState = .failure(error)
                }
            }.store(in: &cancellable)
    }
    
    func getSchedule() {
        self.viewState = .loading
        service
            .schedule()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    guard let self = `self` else {  return }
                    self.schedule = self.ascendingOrder(items: response)
                    self.viewState = .ready
                case .failure(let error):
                    self?.viewState = .failure(error)
                }
            }.store(in: &cancellable)
    }
    
    private func ascendingOrder<T: Video>(items: [T]) -> [T] {
        return items.sorted(by: {
            ($0.startDate ?? Date()).compare($1.startDate ?? Date()) == .orderedAscending
        })
    }
}
