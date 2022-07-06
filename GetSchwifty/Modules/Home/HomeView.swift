//
//  HomeView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var coordinator: HomeCoordinator
    
    var body: some View {
        TabBar(current: $coordinator.currentTab, coordinator: coordinator)
    }
}
