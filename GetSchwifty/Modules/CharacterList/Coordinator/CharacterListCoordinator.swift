//
//  CharacterListCoordinator.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation


class CharacterListCoordinator: ObservableObject {
    
    @Published var characterDetailViewModel: CharacterDetailViewModel?
    @Published var viewModel: CharacterListViewModel!
    
    
    private unowned let parent: HomeCoordinator
    let databaseService: DatabaseService
    
    
    init(parent: HomeCoordinator, databaseService: DatabaseService) {
        self.parent = parent
        self.databaseService = databaseService
        
        self.viewModel = .init(coordinator: self, databaseService: databaseService)
    }
    
    func open(_ characterId: Int) {
        self.characterDetailViewModel = .init(characterId: characterId, coordinator: self)
    }
}
