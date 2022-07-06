//
//  TabBar.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

enum ETabBarItems {
    case CHARACTER_LIST
    case FAVORITES
}

struct TabBar: View {
    
    @Binding var current: ETabBarItems
    @ObservedObject var coordinator: HomeCoordinator
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $current) {
                CharacterListCoordinatorView(coordinator: self.coordinator.characterListCoordinator)
                    .tag(ETabBarItems.CHARACTER_LIST)
                FavoriteListCoordinatorView()
                    .tag(ETabBarItems.FAVORITES)
            }
            
            HStack {
                TabButton(title: .CHARACTER_LIST, image: "circle.grid.cross.fill", selected: $current)
                Spacer()
                TabButton(title: .FAVORITES, image: "circle.square", selected: $current)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(.green)
            .clipShape(Capsule())
            .padding(.horizontal, 25)
            .frame(width: 130)
        }
    }
}
