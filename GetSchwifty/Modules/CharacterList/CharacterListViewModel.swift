//
//  CharacterListViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation
import Combine
import UIKit


class CharacterListViewModel: ObservableObject {
        
    @Published var characters = [Character]()
    @Published var isLoading: Bool = false
    @Published var searchText: String = String()
    @Published var navigationText = "Characters"
    
    private unowned let coordinator: CharacterListCoordinator
    private let databaseService: DatabaseService
    
    private var currentPage: Int = 1
    private var subscription: Set<AnyCancellable> = []
    
    init(coordinator: CharacterListCoordinator, databaseService: DatabaseService) {
        self.coordinator = coordinator
        self.databaseService = databaseService
        
        self.initSearchBar()
    }
    
    func open(_ character: Character) {
        self.coordinator.open(character.id)
    }
    
    
    /// Loads characters data to published property
    /// Triggered when view appears
    public func loadData() -> Void {
        
        // if is something in searchbar
        // after move back from detail
        if (!self.searchText.isEmpty) {
            self.fetchCharacters(page: nil, name: self.searchText) { data in
                DispatchQueue.main.async {
                    self.characters = data
                    self.isLoading = false
                }
            }
            
            return
        }
        
        // reset pagging
        self.fetchCharacters(page: 1) { data in
            self.characters = data
            self.currentPage = 2
        }
    }
    
    
    /// Loads more data to data ot the characters
    public func loadMore() -> Void {
        
        if (self.isLoading) {
            return
        }
        
        self.isLoading = true
        
        self.fetchCharacters(page: currentPage) { data in
            self.characters.append(contentsOf: data)
            self.currentPage += 1
            self.isLoading = false
        }
    }
    
    /// Resets characters data
    public func resetData() -> Void {
        self.characters = []
    }
    
    
    /// Fetchs data from api
    /// - Parameters:
    ///   - page: number of page
    ///   - name: name for filter
    ///   - completion: completion handler
    private func fetchCharacters(page: Int?, name: String? = nil, completion: @escaping ([Character]) -> Void) -> Void {
        
        CharacterService.shared.apollo.fetch(query: CharacterListQuery(page: page, name: name)) { result in
            switch result {
                case .success(let graphQLResult):
                    
                let characters = graphQLResult.data?.characters?.results?.compactMap({ character in
                        Character(character)
                    }) ?? []
                
                self.markFavorites(characters: characters)
                
                completion(characters)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    /// Marks favorite characters
    /// - Parameter characters: array of fetched characters
    private func markFavorites(characters: [Character]) -> Void
    {
        // get fetched character ids
        let characterIds = characters.map({ return $0.id })
        
        // according to ids fetch database data
        let favoriteIds = try? self.databaseService.read(characterIds: characterIds)
        
        // marks favorite characters
        for character in characters {
            if let _ = favoriteIds?[character.id] {
                character.isFavorite = true
            }
        }
    }
    
    
    /// Bind combine on search bar for  data manipulation
    private func initSearchBar() -> Void {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                self.isLoading = true
                searchItems(searchText: searchField)
            }.store(in: &subscription)
    }
    
    
    /// Searchbar action for loading data by search query
    /// - Parameter searchText: search query
    private func searchItems(searchText: String) {
            
        self.fetchCharacters(page: nil, name: searchText) { data in
            DispatchQueue.main.async {
                self.characters = data
                self.isLoading = false
            }
        }
    }
    
    
    public func getSearchingInfoText() -> String {
        
        if (self.searchText.isEmpty) {
            return ""
        }
        
        if (self.isLoading) {
            return "Loading"
        }
        
        return "Nothing found"
    }
}
