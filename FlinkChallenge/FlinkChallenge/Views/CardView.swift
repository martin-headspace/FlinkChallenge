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
    var image : String?
    var name : String?
    var status : String?
    var episodeCount : Int?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                WebImage(url: URL(string: self.image ?? ""))
                .resizable()
                .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                .clipped()
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(self.name ?? "Not nameable character").font(.title).bold()
                        Text(self.status ?? "Unknown").font(.subheadline)
                        Text("Appears in \(self.episodeCount ?? 0) episodes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                }.padding(.horizontal)
            }.padding(.bottom)
                .background(Color.systemGray6)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Card(image: "https://rickandmortyapi.com/api/character/avatar/17.jpeg", name: "Annie", status: "Alive", episodeCount: 5)
    }
}
