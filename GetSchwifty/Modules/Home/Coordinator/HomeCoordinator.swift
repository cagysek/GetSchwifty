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
    @Published var favoritesCoordinator: CharacterListCoordinator!
    
    init(dababaseService: DatabaseService) {
        self.characterListCoordinator = .init(listType: EListType.ALL, parent: self, databaseService: dababaseService)
        self.favoritesCoordinator = .init(listType: EListType.FAVOURITE,parent: self, databaseService: dababaseService)
    }
    
    
}
