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
        
        
        self.characters = self.dummyData()
    }
    
    func open(_ character: Character) {
        self.coordinator.open(character)
    }
    
    
    private func dummyData() -> [Character] {
        return [
            Character(id: 1, name: "Rick sanchez", status: "alive", image: ""),
            Character(id: 2, name: "Morty Smith", status: "alive", image: ""),
            Character(id: 3, name: "Mr. poopyButt", status: "alive", image: ""),
        ]
    }
}
