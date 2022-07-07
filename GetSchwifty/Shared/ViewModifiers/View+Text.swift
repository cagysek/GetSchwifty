//
//  Text.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 07.07.2022.
//

import SwiftUI


extension View {
    func headline1() -> some View {
        modifier(headline1Modifier())
    }
    
    func headline2() -> some View {
        modifier(headline2Modifier())
    }
    
    func headline3() -> some View {
        modifier(headline3Modifier())
    }
    
    func paragraphLarge() -> some View {
        modifier(paragraphLargeModifier())
    }
    
    func paragraphMedium() -> some View {
        modifier(paragraphMediumModifier())
    }
    
    func paragraphSmall() -> some View {
        modifier(paragraphSmallModifier())
    }
}
    
    
struct headline1Modifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold, design: .rounded))
    }
}

struct headline2Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .rounded))
    }
}

struct headline3Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold, design: .rounded))
    }
}

struct paragraphLargeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .regular, design: .rounded))
    }
}

struct paragraphMediumModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .rounded))
    }
}

struct paragraphSmallModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular, design: .rounded))
    }
}
