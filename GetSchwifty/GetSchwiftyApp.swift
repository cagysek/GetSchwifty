//
//  GetSchwiftyApp.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

@main
struct GetSchwiftyApp: App {
    
    @StateObject var coordinator = HomeCoordinator()
    
    var body: some Scene {
        WindowGroup {
            HomeView(coordinator: coordinator)
        }
    }
}
