//
//  ErrorView.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 06/07/2022.
//

import SwiftUI

struct ErrorView: View {
    var didTapRetry: Binding<Bool>
    
    public init(didTapRetry: Binding<Bool>) {
        self.didTapRetry = didTapRetry
    }
    var body: some View {
        VStack {
            ZStack (alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                Image(uiImage: #imageLiteral(resourceName: "encounteredError"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 30) {
                    Text("Something went wrong")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text("An error occured while loading\n Please try again")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                    Button(action: {
                        withAnimation(.interactiveSpring().speed(2)) {
                            withAnimation(.interactiveSpring().speed(2)) {
                                didTapRetry.wrappedValue.toggle()
                            }
                        }
                    }) {
                        Text("Retry")
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    .frame(width: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                    
                }
                .padding(.horizontal, 70)
                .padding(.bottom, UIScreen.main.bounds.height * 0.1)
            }
        }
        .accessibilityIdentifier("errorView")
    }
}

