//
//  CharacterService.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 06.07.2022.
//

import Foundation
import Apollo

final class CharacterService {
    
    static let shared = CharacterService()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
}
