//
//  Extensions.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
