//
//  FavoriteListViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class FavoriteListViewModel: ObservableObject {
    
    
    private unowned let coordinator: FavoriteListCoordinator
    
    
    init(coordinator: FavoriteListCoordinator) {
        self.coordinator = coordinator
        
        
    }
    
    func open(_ character: Character) {
        self.coordinator.open(character.id)
    }
}
