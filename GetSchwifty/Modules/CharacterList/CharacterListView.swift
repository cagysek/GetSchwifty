//
//  CharacterList.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel: CharacterListViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        
            
            List(viewModel.characters) { character in 
                
                
                    HStack {
                        Image(systemName: "house.fill")
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                            Text("Alive")
                        }
                        
                        Spacer()
                    }
                    .onNavigation {
                        self.viewModel.open(character)
                    }
                
                
            }
            .searchable(text: $searchText, prompt: "Search character")
            .navigationTitle("Characters List")
    }
}
