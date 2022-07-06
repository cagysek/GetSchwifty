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
        
        Group {
            if (self.viewModel.characters.isEmpty) {
                Text("Loading")
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.characters) { character in
                            CharacterCellWithBorder(character: character)
                            .onNavigation {
                                self.viewModel.open(character)
                            }
                        
                        }
                        
                        if (self.viewModel.isLoading) {
                            ProgressView()
                        }
                    
                        Color.clear
                            .frame(width: 0, height: 0, alignment: .bottom)
                            .onAppear() {
                                self.viewModel.loadMore()
                            }
                        
                        }
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.loadData()
        })
        .navigationTitle("Characters")
        .searchable(text: $searchText, prompt: "Search character")
        
    }
}
