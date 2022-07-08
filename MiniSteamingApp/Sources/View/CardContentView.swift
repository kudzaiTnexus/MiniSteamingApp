//
//  ContentView.swift
//  MiniSteamingApp
//
//  Created by Kudzaishe Mhou on 04/07/2022.
//

import SwiftUI
import NukeUI

struct CardContentView<T>: View where T: Video {
    var assert: T
    
    var body: some View {
        HStack {
            LazyImage(source: assert.imageURL) { state in
                if let image = state.image {
                    image
                } else if state.error != nil {
                    Color.red
                } else {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .priority(.high)
            .frame(width: 140, height: 100)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
            .accessibilityIdentifier("cardImage")
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(assert.title)
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .fixedSize(horizontal: false, vertical: true)
                    Text(assert.subtitle)
                        .font(.system(size: 12, weight: .regular, design: .default))
                }
                Spacer()
                Text(assert.startDate?.epgStartDate ?? "")
                    .font(.caption)
            }
            
            Spacer()
        }
        .frame(height: 100)
        .accessibilityIdentifier("videoCard")
    }
}
