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
    
    private let databaseService: DatabaseService
    
    let listType: EListType
    
    
    init(listType: EListType, parent: HomeCoordinator, databaseService: DatabaseService) {
        self.parent = parent
        self.databaseService = databaseService
        self.listType = listType
        
        self.viewModel = .init(listType: listType, coordinator: self, databaseService: databaseService)
    }
    
    func open(_ characterId: Int) {
        self.characterDetailViewModel = .init(characterId: characterId, coordinator: self)
    }
    
    func getDatabaseService() -> DatabaseService {
        return self.databaseService
    }
}
