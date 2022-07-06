//
//  Character.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import Foundation

typealias CharacterData = CharacterListQuery.Data.Character

struct Character: Identifiable, Decodable {
    
    var id: String
    var name: String
    var status: String
    var image: String
    
    init(_ character: CharacterData.Result?) {
        self.id = character?.id ?? ""
        self.name = character?.name ?? ""
        self.status = character?.status ?? ""
        self.image = character?.image ?? ""
    }
    
    init(id: String, name: String, status: String, image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.image = image
    }
}


