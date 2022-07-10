//
//  View+if.swift
//  GetSchwifty
//
//  Created by Jan Čarnogurský on 10.07.2022.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    /// Custom view `if` extension
    /// - Parameters:
    ///   - condition: condition
    ///   - transform: what happend with view if condition is true
    /// - Returns: view
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
