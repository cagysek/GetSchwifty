//
//  TabuButton.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct TabButton: View {

    var title: ETabBarItems
    var image: String

    @Binding var selected: ETabBarItems
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) { selected = title }
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
        })
    }
}

