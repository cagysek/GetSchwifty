//
//  CharacterList.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct CharacterListView: View {
    
    @Environment(\.isSearching) var isSearching
    
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        
        Group {
            if (self.viewModel.characters.isEmpty) {
                if (self.isSearching) {
                    
                    Text(self.viewModel.getSearchingInfoText())
                } else {
                    Text("Loading")
                }
                    
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.characters) { character in
                            CharacterCell(character: character, hasWhiteBackground: !viewModel.isSearching)
                            .onNavigation {
                                self.viewModel.open(character)
                            }
                        }
                        
                        if (self.viewModel.isLoading) {
                            ProgressView()
                        }
                    
                        if (self.viewModel.isEnabledLoadMore()) {
                            Color.clear
                                .frame(width: 0, height: 0, alignment: .bottom)
                                .onAppear() {
                                    self.viewModel.loadMore()
                                }
                        }
                        
                    }
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.loadData()
            self.viewModel.navigationText = self.viewModel.getNavigationTitle()
        })
        .onChange(of: isSearching, perform: { isSearching in
            if (isSearching) {
                self.viewModel.resetData()
            }
            else {
                self.viewModel.loadData()
            }
        })
        .navigationTitle(self.viewModel.navigationText)
        
    }
}
