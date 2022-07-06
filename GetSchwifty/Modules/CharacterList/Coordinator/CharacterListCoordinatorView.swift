//
//  CharacterListView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct CharacterListCoordinatorView: View {
    
    @ObservedObject var coordinator: CharacterListCoordinator
    
    var body: some View {
        
        NavigationView {
            CharacterListView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.characterDetailViewModel) { viewModel in
                    CharacterDetailView(viewModel: viewModel)
                }
        }
    }
}
