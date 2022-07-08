//
//  ScheduleView.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    private var cancellable: AnyCancellable?
    private let pollingViewModel = PollingViewModel()
    
    @State var didTapRetry: Bool = false
    @State var showLoadingIndicator: Bool = true
    @StateObject var viewModel: EPGViewModel
    
    init(viewModel: EPGViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var loadedView: some View {
        List(viewModel.schedule) { schedule in
            CardContentView<Schedule>(assert: schedule)
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 16)
                .listRowInsets(.init())
        }
        .listStyle(PlainListStyle())
    }
    
    var loadingView: some View {
        ActivityIndicator(
            isAnimating: $showLoadingIndicator,
            style: .large,
            color: .white
        )
        .frame(
            width: 20,
            height: showLoadingIndicator ? 20 : 0,
            alignment: .center
        )
    }
    
    var errorView: some View {
        return ErrorView(didTapRetry: $didTapRetry)
    }
    
    var body: some View {
        VStack{
            switch viewModel.viewState {
            case .loading, .ready:
                loadedView.overlay(loadingView)
                    .animation(.easeIn, value: 0.5)
                    .transition(.opacity)
            case .failure:
                errorView
            }
        }
        .onChange(of: didTapRetry, perform: { _ in
            pollingViewModel.beginPolling()
            viewModel.getEvents()
        })
        .onReceive(pollingViewModel.timer, perform: { _ in
            viewModel.getSchedule()
        })
        .onReceive(viewModel.$viewState) { viewState in
            switch viewState {
            case .loading:
                showLoadingIndicator = true
            case .failure:
                showLoadingIndicator = false
                pollingViewModel.stopPolling()
            default:
                showLoadingIndicator = false
            }
        }
        .onAppear {
            viewModel.getSchedule()
            pollingViewModel.beginPolling()
        }
        .onDisappear {
            pollingViewModel.stopPolling()
        }
    }
}

