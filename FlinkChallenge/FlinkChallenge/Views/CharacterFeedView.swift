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
        VStack {
            List(characterFeed) { (character: APICharacter) in
                HStack{
                    Spacer()
                    Card(character: character).frame(width: 300, height: 300)
                        .onAppear {
                            self.characterFeed.loadMoreCharacters(currentItem: character)
                    }
                    Spacer()
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
