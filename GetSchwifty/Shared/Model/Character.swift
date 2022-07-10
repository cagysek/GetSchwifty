//
//  Character.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

typealias CharacterData = CharacterListQuery.Data.Character
typealias CharacterByIdsData = CharacterListByIdsQuery.Data.CharactersById

class Character: Identifiable, Decodable {
    
    var id: Int
    var name: String
    var status: String
    var image: String
    public var isFavorite: Bool = false
    
    init(_ character: CharacterData.Result?, isFavourite: Bool = false) {
        self.id = Int(character?.id ?? "0") ?? 0
        self.name = character?.name ?? ""
        self.status = character?.status ?? ""
        self.image = character?.image ?? ""
        self.isFavorite = isFavourite
    }
    
    init(_ character: CharacterByIdsData?, isFavourite: Bool = false) {
        self.id = Int(character?.id ?? "0") ?? 0
        self.name = character?.name ?? ""
        self.status = character?.status ?? ""
        self.image = character?.image ?? ""
        self.isFavorite = isFavourite
    }
    
    init(id: Int, name: String, status: String, image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.image = image
    }
}


