//
//  CharacterDetailViewModel.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var characterDetail: CharacterDetail? = nil
    
    private let characterId: String
    private unowned let coordinator: CharacterListCoordinator
    
    init(characterId: String, coordinator: CharacterListCoordinator) {
        self.characterId = characterId
        self.coordinator = coordinator
    }
    
    
    public func loadData() -> Void {
        CharacterService.shared.apollo.fetch(query: CharacterQuery(id: self.characterId)) { result in
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
}
