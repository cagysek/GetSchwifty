//
//  FavoriteListView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject var viewModel: FavoriteListViewModel
    
    var body: some View {
        Group {
            Text("FAV list")
        }
        .navigationTitle("Favorites")
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(viewModel: FavoriteListViewModel(coordinator: FavoriteListCoordinator(parent: HomeCoordinator(dababaseService: DatabaseService()))))
    }
}
