//
//  CharacterListViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation


class CharacterListViewModel: ObservableObject {
        
    @Published var characters = [Character]()
    
    private unowned let coordinator: CharacterListCoordinator
    
    
    init(coordinator: CharacterListCoordinator) {
        self.coordinator = coordinator
    }
    
    func open(_ character: Character) {
        self.coordinator.open(character)
    }
    
    
    public func loadData() -> Void {
        
        CharacterService.shared.apollo.fetch(query: CharacterListQuery()) { result in

            switch result {
                case .success(let graphQLResult):
                    
                self.characters = graphQLResult.data?.characters?.results?.compactMap({ character in
                        Character(character)
                    }) ?? []
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
