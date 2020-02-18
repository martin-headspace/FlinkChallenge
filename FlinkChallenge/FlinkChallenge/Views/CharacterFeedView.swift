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
    
    var body: some View {
        List(characterFeed) { (character: APICharacter) in
            CharacterListItemView(character: character)
                .onAppear {
                    self.characterFeed.loadMoreCharacters(currentItem: character)
            }
        }
    }
}

struct CharacterListItemView : View {
    var character : APICharacter
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(character.name ?? "Gazorpazork")")
                Text("\(character.gender ?? "None")").font(.subheadline)
            }
        }
    }
}

struct CharacterFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFeedView()
    }
}
