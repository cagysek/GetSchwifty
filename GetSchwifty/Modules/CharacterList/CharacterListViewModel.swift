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
    
    private unowned let coordinator: CharacterListCoordinator
    private var currentPage: Int = 1
    private var subscription: Set<AnyCancellable> = []
    
    init(coordinator: CharacterListCoordinator) {
        self.coordinator = coordinator
        
        self.initSearchBar()
    }
    
    func open(_ character: Character) {
        self.coordinator.open(character)
    }
    
    
    public func loadData() -> Void {
        self.fetchCharacters(page: 1) { data in
            self.characters = data
            self.currentPage = 2
        }
        
    }
    
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
    
    public func startSearching() -> Void {
        self.characters = []
    }
    
    private func fetchCharacters(page: Int?, name: String? = nil, completion: @escaping ([Character]) -> Void) -> Void {
        
        
        CharacterService.shared.apollo.fetch(query: CharacterListQuery(page: page, name: name)) { result in
            switch result {
                case .success(let graphQLResult):
                    
                let data = graphQLResult.data?.characters?.results?.compactMap({ character in
                        Character(character)
                    }) ?? []
                
                completion(data)
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
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
