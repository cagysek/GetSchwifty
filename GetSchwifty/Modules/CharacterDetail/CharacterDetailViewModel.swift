//
//  CharacterDetailViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var characterDetail: CharacterDetail? = nil
    @Published var isFavorite: Bool = false
    
    private let characterId: Int
    private unowned let coordinator: CharacterListCoordinator
    
    init(characterId: Int, coordinator: CharacterListCoordinator) {
        self.characterId = characterId
        self.coordinator = coordinator
        
        isFavoriteCharacter()
    }
    
    
    /// Loads data for character
    public func loadData() -> Void {
        CharacterService.shared.apollo.fetch(query: CharacterQuery(id: String(self.characterId))) { result in
            switch result {
                case .success(let graphQLResult):
                    
                guard let characterData = graphQLResult.data?.character else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.characterDetail = CharacterDetail(characterData)
                    self.coordinator.viewModel.navigationText = self.characterDetail!.name
                }
                
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    /// Fancy mapper for character info...
    /// - Parameter characterDetail: Detail information avout character
    /// - Returns: datasource for print statistics
    public func getCharacterStats(_ characterDetail: CharacterDetail) -> [String] {
        return [
            "Status", characterDetail.status,
            "Species", characterDetail.species,
            "Type", characterDetail.type,
            "Gender", characterDetail.gender,
            "Origin", characterDetail.origin,
            "Location", characterDetail.location,
        ]
    }
    
    public func isFavoriteCharacter() -> Void {
        let result = try? self.coordinator.databaseService.read(characterIds: [characterId])
        
        
        self.isFavorite = !(result?.isEmpty ?? true)
    }
    
    public func markFavorite() -> Void {
        self.coordinator.databaseService.create(characterId: characterId)
        
        self.isFavorite = true
    }
    
    public func unmarkFavorite() -> Void {
        self.coordinator.databaseService.delete(characterId: characterId)
        
        self.isFavorite = false
    }
}
