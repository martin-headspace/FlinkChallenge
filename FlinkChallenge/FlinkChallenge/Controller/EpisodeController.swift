//
//  EpisodeController.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

class EpisodeController : ObservableObject, RandomAccessCollection{
    typealias Element = Episode
    @Published var episodeList = [Episode]()
    
    var startIndex: Int { episodeList.startIndex }
    var endIndex: Int { episodeList.endIndex }
    
    subscript(position: Int) -> Episode {
        return episodeList[position]
    }
    
    init(episodes : [String]) {
        getEpisodes(episodes: episodes)
    }
    
    /**
           Retrieves an episode from a given URL and appends it to the episode list
           - Parameters:
                - url: Episode URL
    */
    private func getEpisodeFromURL(with url : String) {
        if let url = URL(string: url) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Episode.self, from: data)
                        self.episodeList.append(response)
                    } catch {
                        print(error.localizedDescription)
                    }
               }
           }.resume()
        }
    }
    
    /**
           Retrieves all episodes and appends it to the list observable
           - Parameters:
                - episodes: Episode Array
    */
    func getEpisodes(episodes : [String]) {
        for episode in episodes {
            DispatchQueue.main.async {
                self.getEpisodeFromURL(with: episode)
            }
        }
    }
}
