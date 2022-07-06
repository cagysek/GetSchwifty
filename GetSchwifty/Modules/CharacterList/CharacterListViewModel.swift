//
//  CharacterListViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation


class CharacterListViewModel: ObservableObject {
        
    @Published var characters = [Character]()
    @Published var isLoading: Bool = false
    
    private unowned let coordinator: CharacterListCoordinator
    private var currentPage: Int = 1
    
    
    init(coordinator: CharacterListCoordinator) {
        self.coordinator = coordinator
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
        
        print("load more")
        self.isLoading = true
        
        self.fetchCharacters(page: currentPage) { data in
            self.characters.append(contentsOf: data)
            self.currentPage += 1
            self.isLoading = false
        }
    }
    
    private func fetchCharacters(page: Int, completion: @escaping ([Character]) -> Void) -> Void {
        
        
        CharacterService.shared.apollo.fetch(query: CharacterListQuery(page: page)) { result in
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
}
