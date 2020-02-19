//
//  CardView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Card: View {
    var character : APICharacter

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                WebImage(url: URL(string: self.character.image ?? ""))
                .resizable()
                .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                .clipped()
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(self.character.name ?? "Not nameable character").font(.title).bold()
                        Text(self.character.status ?? "Unknown").font(.subheadline)
                        Text("Appears in \(self.character.episode?.count ?? 0) episodes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }.padding(.horizontal)
            }.padding(.bottom)
                .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
