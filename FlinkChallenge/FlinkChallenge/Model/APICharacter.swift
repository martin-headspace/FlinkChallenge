//
//  RickAndMortyModels.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

class APICharactersResponse : Codable {
    var info : Info?
    var results : [APICharacter]?
}

class APICharacter : Identifiable, Codable {
    var id : Int?
    var name: String?
    var status : String?
    var type: String?
    var gender : String?
    var origin : Location?
    var location : Location?
    var species : String?
    var image : String?
    var episode : [String]?
    var url : String?
    var created : String?
    
    init(){
        self.id = 1
        self.name = "Rick Sanchez"
        self.status = "Alive"
        self.species = "Human"
        self.type = ""
        self.gender = "Male"
        self.origin = Location.init()
        self.location = Location.init()
        self.image = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        self.episode = ["https://rickandmortyapi.com/api/episode/1"]
        self.url = "https://rickandmortyapi.com/api/character/1"
        self.created = "2017-11-04T18:48:46.250Z"
    }
}

class Location : Codable {
    var name : String?
    var url : String?
    init() {
        self.name = "Earth"
        self.url = "https://rickandmortyapi.com/api/location/20"
    }
}

class Info : Codable {
    var count : Int?
    var pages: Int?
    var next : String?
    var prev: String?
}
