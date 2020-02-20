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
    
    /**
            Loads Characters from URL
            - Parameter currentItem: Receives the currentItem that is displayed to determine if it should load more characters
     */
    func loadMoreCharacters(currentItem: APICharacter? = nil) {
        // Check if data should or shouldn't be loaded
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        
        // Check if the page we need to load is ready to be loaded
        guard case let .ready(page) = loadStatus else {
            return
        }
        // Start downloading using URLSession
        loadStatus = .loading(page: page)
        let completeURL = "\(baseURL)\(page)"
        let url = URL(string: completeURL)!
        let task = URLSession.shared.dataTask(with: url,completionHandler: parseCharactersFromResponse(data:response:error:))
        task.resume()
    }
    
    /**
           Determines if more characters are needed to be downloaded
           - Parameter currentItem: Receives the currentItem that is displayed to determine if it should load more characters
           - Returns: True if more characters should be loaded or false otherwise
    */
    func shouldLoadMoreData(currentItem : APICharacter? = nil) -> Bool{
        guard let currentItem = currentItem else {
            return true
        }
        
        // If the current character retrieved is within 4 of the last element of the page, we should load more
        for n in (characterListItems.count - 4)...(characterListItems.count - 1) {
            if n >= 0 && currentItem.id == characterListItems[n].id {
                return true
            }
        }
        return false
    }
    
    /**
           Parses the response from Rick and Morty's API to the required structure
           - Parameters:
                - data: Response data from the URLRequest Closure
                - response: URLResponse object to check for any data we should find useful
                - error: Error object to retrieve possible mistakes
    */
    func parseCharactersFromResponse(data: Data?, response : URLResponse?, error : Error?) {
        // Check if any error occurred and pass the status as a bad state
        guard error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            loadStatus = .parseError
            return
        }
        // Check if data is present, else, pass it as a bad state
        guard let data = data else {
            print("Error: \(error?.localizedDescription ?? "Unknown error produced")")
            loadStatus = .parseError
            return
        }
        
        // Parse Data into an array of characters
        let apiCharacters = parseCharactersFromData(data: data)
        
        // Pass characters through main.async to display them on the List
        DispatchQueue.main.async {
            // Pass all new characters to the list
            self.characterListItems.append(contentsOf: apiCharacters)
            // If no more characters are available, we're done
            if apiCharacters.count == 0 {
                self.loadStatus = .done
            } else {
                // If we passed all characters and we still HAVE some, something weird is happening
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("Load status is in a bad state")
                }
                // If everything is done, we can load the next page
                self.loadStatus = .ready(nextPage: page + 1)
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
