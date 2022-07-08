//
//  PlayerView.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 05/07/2022.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var player: AVPlayer
    
    init(videoUrl: URL) {
        player = AVPlayer(url: videoUrl)
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: player, videoOverlay: {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("🏁 DA-Zone 🏁")
                            .foregroundColor(.white)
                    }
                }.padding()
            })
            .accessibilityIdentifier("videoPlayer")
            .frame(height: 320)
            .onAppear { player.play() }
            .onDisappear { player.pause() }
            .padding(.top, 40)
            
            Spacer()
        }
        .overlay(
            VStack {
                HStack{
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    }
                    .padding([.trailing], 16)
                    .accessibilityIdentifier("closeButton")
                }
                Spacer()
            }
        )
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(videoUrl: URL(string: "https://bit.ly/swswift")!)
    }
}
