//
//  FavoritesListCoordinator.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class FavoriteListCoordinator: ObservableObject {
 
    @Published var characterDetailViewModel: CharacterDetailViewModel?
    @Published var viewModel: FavoriteListViewModel!
    
    
    private unowned let parent: HomeCoordinator
    
    
    init(parent: HomeCoordinator) {
        self.parent = parent
        
        self.viewModel = .init(coordinator: self)
    }
    
    func open(_ characterId: String) {
//        self.characterDetailViewModel = .init(characterId: characterId, coordinator: self)
    }
    
}
