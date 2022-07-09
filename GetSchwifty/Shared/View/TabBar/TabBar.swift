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
    
    init(current: Binding<ETabBarItems>, coordinator: HomeCoordinator) {
        
        self.coordinator = coordinator
        self._current = current
        
        UITabBar.appearance().standardAppearance = uiTabBarAppearance
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $current) {
                CharacterListCoordinatorView(coordinator: self.coordinator.characterListCoordinator)
                    .tag(ETabBarItems.CHARACTER_LIST)
                    
                    
                FavoriteListCoordinatorView(coordinator: self.coordinator.favoritesCoordinator)
                    .tag(ETabBarItems.FAVORITES)
            }
            
            HStack {
                Spacer()
                TabButton(title: .CHARACTER_LIST, image: Image("rick-icon"), selected: $current)
                Spacer()
                TabButton(title: .FAVORITES, image: Image(systemName:"star"), selected: $current)
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("backgroundsTertiary"))
            .clipShape(Capsule())
            .padding(.horizontal, 25)
            .frame(width: 240)
            .shadow(color: Color("foregroundsTertiary").opacity(0.6), radius: 10)
        }
    }
}

fileprivate var uiTabBarAppearance: UITabBarAppearance {
    let appearance = UITabBarAppearance()
    appearance.configureWithTransparentBackground()
    
            
    return appearance
}



struct TabButton_Previews: PreviewProvider {
    
    
    static var previews: some View {
        TabBar(current: .constant(ETabBarItems.CHARACTER_LIST), coordinator: HomeCoordinator(dababaseService: DatabaseService()))
    }
}
