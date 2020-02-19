//
//  CharacterFeedView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct CharacterFeedView: View {
    @ObservedObject var characterFeed = CharacterFeed()
    @State private var searchText : String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search for characters")
            List {
                ForEach(self.characterFeed.filter {
                    self.searchText.isEmpty ? true : $0.name!.lowercased().contains(self.searchText.lowercased())
                }, id: \.id) { character in
                    ZStack {
                        Card(character: character).frame(width: 300, height: 300)
                            .onAppear {
                                self.characterFeed.loadMoreCharacters(currentItem: character)
                        }
                    NavigationLink(destination: CharacterDetail(character: character)) {
                        EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
}

struct CharacterFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFeedView()
    }
}
