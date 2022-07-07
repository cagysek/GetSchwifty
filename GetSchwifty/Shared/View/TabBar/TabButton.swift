//
//  TabuButton.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct TabButton: View {

    var title: ETabBarItems
    
    var image: Image

    @Binding var selected: ETabBarItems
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) { selected = title }
        }, label: {
            HStack(spacing: 10) {
                image
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundColor(selected == title ?  Color("iconsTertiary") : Color("iconsSecondary"))
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .clipShape(Capsule())
        })
    }
}

