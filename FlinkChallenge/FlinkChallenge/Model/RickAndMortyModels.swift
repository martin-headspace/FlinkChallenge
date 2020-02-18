//
//  RickAndMortyModels.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

class APICharactersResponse : Codable {
    var info : Info
    var characters : [APICharacter]
}

class APICharacter : Identifiable, Codable {
    var id : Int
    var name: String
    var status : String
    var type: String
    var gender : String
    var origin : Location
    var destination : Location
    var image : String
    var episode : [String]
    var url : String
    var created : String
}

class Location : Codable {
    var name : String
    var url : String
}

class Info : Codable {
    var count : Int
    var pages: Int
    var next : String
    var prev: String
}
