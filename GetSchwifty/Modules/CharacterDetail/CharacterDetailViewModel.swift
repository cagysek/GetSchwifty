//
//  CharacterDetailViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    
    @Published var character: Character
    
    private unowned let coordinator: CharacterListCoordinator
    
    init(character: Character, coordinator: CharacterListCoordinator) {
        self.character = character
        self.coordinator = coordinator
    }
}
