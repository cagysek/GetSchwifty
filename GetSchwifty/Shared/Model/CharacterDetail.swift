//
//  CharacterDetail.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 07.07.2022.
//

import Foundation

typealias CharacterDetailData = CharacterQuery.Data.Character

struct CharacterDetail: Identifiable, Decodable {
    var id: String
    var name: String
    var image: String
    var species: String
    var status: String
    var gender: String
    var type: String
    var origin: String
    var location: String
    
    init(_ characterData: CharacterDetailData) {
        self.id = characterData.id ?? ""
        self.name = characterData.name ?? "-"
        self.image = characterData.image ?? ""
        self.species = characterData.species ?? "-"
        self.status = characterData.status ?? "-"
        self.gender = characterData.gender ?? "-"
        self.type = characterData.type != nil ? (characterData.type!.isEmpty ? "-" : characterData.type)! : "-"
        self.origin = characterData.origin?.name ?? "-"
        self.location = characterData.location?.name ?? "-"
    }
}
