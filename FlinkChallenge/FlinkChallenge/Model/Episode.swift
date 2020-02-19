//
//  Episode.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

class Episode : Identifiable, Codable, Hashable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(air_date)
        hasher.combine(episode)
        hasher.combine(characters)
    }
    
    var id: Int?
    var name : String?
    var air_date : String?
    var episode : String?
    var characters : [String]?
    var url : String
    var created : String
    
    init() {
        id = 0
        name = "No episode was found"
        air_date = "N/A"
        episode = "N/A"
        characters = ["N/A"]
        url = ""
        created = ""
    }
}
