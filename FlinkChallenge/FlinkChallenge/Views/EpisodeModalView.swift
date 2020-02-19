//
//  EpisodeModalView.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import SwiftUI

struct EpisodeModalView: View {
    var episode : Episode 
    var body: some View {
        VStack {
            Text(episode.name!).font(.largeTitle).bold().multilineTextAlignment(.center)
            Text(episode.episode!)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("This episode aired on \(episode.air_date!)")
            .font(.body)
            Text("\(episode.characters?.count ?? 0) character\(episode.characters?.count ?? 0 > 1 ? "s" : "") appeared on this episode")
        }
    }
}

struct EpisodeModalView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeModalView(episode: Episode())
    }
}
