//
//  EventsView.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import SwiftUI

struct EventsView: View {
    @State var showLoadingIndicator: Bool = true
    @State var didTapRetry: Bool = false
    @State var showingPlayer: Bool = false
    @StateObject var viewModel: EPGViewModel
    
    init(viewModel: EPGViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var loadedView: some View {
        List(viewModel.events) { event in
            CardContentView<Event>(assert: event)
                .onTapGesture {
                    showingPlayer = true
                }
                .fullScreenCover(isPresented: $showingPlayer, content: {
                    if let videoUrl = URL(string: event.videoURL)  {
                        PlayerView(videoUrl: videoUrl)
                            .accessibilityIdentifier("playerView")
                    }
                })
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 16)
                .listRowInsets(.init())
                .accessibilityIdentifier("videoCard")
        }
        .accessibilityIdentifier("eventsList")
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
                    .animation(.easeInOut(duration: 0.5))
                    .transition(.opacity)
            case .failure:
                errorView
            }
        }
        .onChange(of: didTapRetry, perform: { newValue in
            viewModel.getEvents()
        })
        .onReceive(viewModel.$viewState) { viewState in
            switch viewState {
            case .loading:
                showLoadingIndicator = true
            default:
                showLoadingIndicator = false
            }
        }
        .onAppear {
            viewModel.getEvents()
        }
    }
}

