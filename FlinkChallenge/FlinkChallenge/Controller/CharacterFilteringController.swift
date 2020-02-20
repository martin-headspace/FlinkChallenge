//
//  CharacterFilteringController.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 19/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

class CharacterFiltering : ObservableObject, RandomAccessCollection {
    typealias Element = APICharacter
    @Published var characterListItems = [APICharacter]()
    
    var startIndex: Int { characterListItems.startIndex }
    var endIndex: Int { characterListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var baseURL = "https://rickandmortyapi.com/api/character/?"
    
    init(name : String, status : String, species: String, type : String, gender: String){
        loadFilteredCharacters(params: [name,status,species,type, gender])
    }
    
    subscript(position: Int) -> APICharacter {
        return characterListItems[position]
    }
    
    /**
           Retrieves a character array based on passed parameters
           - Parameters:
                - params: Array of possible search params (name, status, species, type, and gender)
    */
    func loadFilteredCharacters(params : [String]) {
        var leadingQueryString : String = ""
        let labels = ["name","status","species","type","gender"]
        for (index, param) in params.enumerated() {
            if !param.isEmpty {
                leadingQueryString += "\(labels[index])=\(param.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
            }
            
            if index != params.count {
                leadingQueryString += "&"
            }
        }
        let completeURL = "\(baseURL)\(leadingQueryString)"
        let url = URL(string: completeURL)!
        let task = URLSession.shared.dataTask(with: url,completionHandler: parseCharactersFromResponse(data:response:error:))
        task.resume()
    }
    
    /**
           Parses characters from response and error handles any possible issue
           - Parameters:
            - data: Response data from the URLRequest Closure
            - response: URLResponse object to check for any data we should find useful
            - error: Error object to retrieve possible mistakes
    */
    func parseCharactersFromResponse(data: Data?, response : URLResponse?, error : Error?) {
        guard error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            return
        }
        
        guard let data = data else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            return
        }
        
        let apiCharacters = parseCharactersFromData(data: data)
        DispatchQueue.main.async {
            self.characterListItems.append(contentsOf: apiCharacters)
            if apiCharacters.count == 0 {
                print("load status done")
            } else {
                print("load status unknown")
            }
        }
    }
    
    /**
          Parses the Data from Rick and Morty's request to an array of characters
          - Parameters:
               - data: Response data from the URLRequest Closure
            - Returns: Array of APICharacters
       */
    func parseCharactersFromData(data: Data) -> [APICharacter] {
        var response : APICharactersResponse
        do {
            response = try JSONDecoder().decode(APICharactersResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
        
        return response.results ?? []
    }
}
