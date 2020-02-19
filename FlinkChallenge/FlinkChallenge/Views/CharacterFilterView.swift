//
//  CharacterFilterView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 19/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct CharacterFilterView: View {
    @ObservedObject var characterFeed : CharacterFiltering
    @State private var searchText : String = ""
    
    init(name : String, status: String, species : String, type: String) {
        characterFeed = CharacterFiltering(name: name, status: status, species: species, type: type)
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search for characters")
            List {
                ForEach(self.characterFeed.filter {
                    self.searchText.isEmpty ? true : $0.name!.lowercased().contains(self.searchText.lowercased())
                }, id: \.id) { character in
                    ZStack {
                        Card(character: character).frame(width: 300, height: 300)
                    NavigationLink(destination: CharacterDetail(character: character)) {
                        EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }.navigationBarTitle(Text("Search Results"))
    }
}

struct CharacterFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFilterView(name: "Rick", status: "", species: "", type: "")
    }
}
