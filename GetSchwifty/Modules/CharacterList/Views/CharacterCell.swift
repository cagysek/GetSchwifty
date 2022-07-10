//
//  CharacterCellWithBorder.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 06.07.2022.
//

import SwiftUI

struct CharacterCell: View {
    
    var character: Character
    var hasWhiteBackground: Bool
    
    var body: some View {
        ZStack {
            if (hasWhiteBackground) {
                Color("backgroundsTertiary")
            }
            
            
            HStack {
                AsyncImage(url: URL(string: character.image) ?? nil)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(8)
                    
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(character.name)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color("foregroundsPrimary"))
                        
                        if (character.isFavorite) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("iconsTertiary"))
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                        }
                        
                    }
                    
                    
                    Text(character.status)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color("foregroundsSecondary"))
                    .font(.system(size: 16, weight: .bold))
                    .padding(.trailing)
                
            }
        }
        
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.trailing)
        .padding(.leading)
        .padding(.top, 7)
        .shadow(color: Color("foregroundsTertiary").opacity(0.3), radius: 8)
        .fixedSize(horizontal: false, vertical: true)
        
    }
}

struct CharacterCellWithBorder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: false)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez Rick Sanchez Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: true)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: true)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: true)
            }
            VStack {
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: true)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez Rick Sanchez Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: true)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: false)
                
                CharacterCell(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"), hasWhiteBackground: false)
            }
            .preferredColorScheme(.dark)
        }
    }
}

