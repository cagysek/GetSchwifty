//
//  FavoritesListCoordinatorView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct FavoriteListCoordinatorView: View {
    
    @ObservedObject var coordinator: FavoriteListCoordinator
    
    var body: some View {
        NavigationView {
            FavoriteListView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.characterDetailViewModel) { viewModel in
                    CharacterDetailView(viewModel: viewModel)
                }
                .background(Color("backgroundsPrimary"))
        }
    }
}

struct FavoriteListCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListCoordinatorView(coordinator: FavoriteListCoordinator(parent: HomeCoordinator(dababaseService: DatabaseService())))
    }
}
