//
//  SwiftUIView.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 07.07.2022.
//

import SwiftUI


struct WidthPreferenceSettingView: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: WidthPreferenceKey.self,
                    value: [WidthPreference(width: geometry.frame(in: CoordinateSpace.global).width)]
                )
        }
    }
}

struct WidthPreferenceKey: PreferenceKey {
    typealias Value = [WidthPreference]
    
    static var defaultValue: [WidthPreference] = []
    
    static func reduce(value: inout [WidthPreference], nextValue: () -> [WidthPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct WidthPreference: Equatable {
    let width: CGFloat
}

struct SwiftUIView: View {
    
    @State private var width: CGFloat? = nil

    
    var body: some View {
        
        List {
                    HStack {
                        Text("1. ")
                            .frame(width: width, alignment: .leading)
                            .lineLimit(1)
                            .background(WidthPreferenceSettingView())
                        Text("John Smith")
                    }
                    HStack {
                        Text("20. ")
                            .frame(width: width, alignment: .leading)
                            .lineLimit(1)
                            .background(WidthPreferenceSettingView())
                        Text("Jane Done")
                    }
                    HStack {
                        Text("2000. ")
                            .frame(width: width, alignment: .leading)
                            .lineLimit(1)
                            .background(WidthPreferenceSettingView())
                        Text("Jax Dax")
                    }
                }.onPreferenceChange(WidthPreferenceKey.self) { preferences in
                    for p in preferences {
                        let oldWidth = self.width ?? CGFloat.zero
                        if p.width > oldWidth {
                            self.width = p.width
                        }
                    }
                }
                .listStyle(.plain)
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
