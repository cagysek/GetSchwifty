//
//  HomeCoordinator.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class HomeCoordinator: ObservableObject {
    
    
    @Published var currentTab = ETabBarItems.CHARACTER_LIST
    
    @Published var characterListCoordinator: CharacterListCoordinator!
    @Published var favoritesCoordinator: FavoriteListCoordinator!
    
    init(dababaseService: DatabaseService) {
        self.characterListCoordinator = .init(parent: self, databaseService: dababaseService)
        self.favoritesCoordinator = .init(parent: self)
    }
    
    
}
