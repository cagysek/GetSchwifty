//
//  CharacterDetailView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 05.07.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        Group {
            if (self.viewModel.characterDetail == nil) {
                Text("Loading")
            } else {
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .top) {
                        Color("backgroundsTertiary")
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                AsyncImage(url: URL(string: self.viewModel.characterDetail!.image))
                                    .frame(width: 130, height: 130)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.leading)
                                    .padding(.top)
                                    .padding(.trailing, 7)
                                
                                VStack(alignment: .leading) {
                                    Text("Name")
                                        .paragraphMedium()
                                        .foregroundColor(Color("foregroundsSecondary"))
                                        .padding(.bottom, 12)
                                        .padding(.top, 22)
                                    
                                    ForEach(self.viewModel.characterDetail!.name.components(separatedBy: " "), id:\.self) { value in
                                        Text(value)
                                            .headline2()
                                            .foregroundColor(Color("foregroundsPrimary"))
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "star")
                                    .font(.system(size: 25, weight: .regular, design: .rounded))
                                    .foregroundColor(.gray)
                                    .padding(.top, 15)
                                    .padding(.trailing, 15)
                                
                                
                            }
                            
                            Divider()
                                .foregroundColor(.black)
                            
                            
                            Stats(data: self.viewModel.getCharacterStats(viewModel.characterDetail!))
                                
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray.opacity(0.3), radius: 15)
                    .padding()
                }
            }

        }
        .background(Color("backgroundsPrimary"))
        .onAppear {
            self.viewModel.loadData()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Stats: View {
    
    let data: [String]
    
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: 30)
        {
            // dictionary can not be used (loses order of the elements)
            ForEach(0 ..< data.count, id: \.self) { i in
                if (i % 2 == 0) {
                    Text(data[i])
                        .paragraphMedium()
                        .foregroundColor(Color("foregroundsSecondary"))
                } else {
                    Text(data[i])
                        .headline3()
                        .foregroundColor(Color("foregroundsPrimary"))
                }
            }
        }
        .padding()
        .padding(.leading, 10)
    }
}





struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(viewModel: CharacterDetailViewModel(characterId: "1", coordinator: CharacterListCoordinator(parent: HomeCoordinator())))
    }
}
