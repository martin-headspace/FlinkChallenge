//
//  FeedModels.swift
//  FlinkChallenge
//
//  Created by Fernando Martin Garcia Del Angel on 18/02/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import Foundation

enum LoadStatus {
    case ready (nextPage: Int)
    case loading (page: Int)
    case parseError
    case done
}

class CharacterFeed : ObservableObject, RandomAccessCollection {
    typealias Element = APICharacter
    @Published var characterListItems = [APICharacter]()
    
    var startIndex: Int { characterListItems.startIndex }
    var endIndex: Int { characterListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var baseURL = "https://rickandmortyapi.com/api/character/?page="
    
    init(){
        loadMoreCharacters()
    }
    
    subscript(position: Int) -> APICharacter {
        return characterListItems[position]
    }
    
    func loadMoreCharacters(currentItem: APICharacter? = nil) {
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        
        guard case let .ready(page) = loadStatus else {
            return
        }
        
        loadStatus = .loading(page: page)
        let completeURL = "\(baseURL)\(page)"
        let url = URL(string: completeURL)!
        let task = URLSession.shared.dataTask(with: url,completionHandler: parseCharactersFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem : APICharacter? = nil) -> Bool{
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (characterListItems.count - 4)...(characterListItems.count - 1) {
            if n >= 0 && currentItem.id == characterListItems[n].id {
                return true
            }
        }
        return false
    }
    
    func parseCharactersFromResponse(data: Data?, response : URLResponse?, error : Error?) {
        guard error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            loadStatus = .parseError
            return
        }
        
        guard let data = data else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            loadStatus = .parseError
            return
        }
        
        let apiCharacters = parseCharactersFromData(with: data)
        DispatchQueue.main.async {
            self.characterListItems.append(contentsOf: apiCharacters)
            if apiCharacters.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("Load status is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
    
    func parseCharactersFromData(with data: Data) -> [APICharacter] {
        var response : APICharactersResponse
        do {
            response = try JSONDecoder().decode(APICharactersResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
        
        return response.characters 
    }
    
}
