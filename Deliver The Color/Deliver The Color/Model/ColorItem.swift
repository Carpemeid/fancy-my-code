//
//  ColorItem.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

enum ColorItem: String, CaseIterable {
    case blue
    case cyan
    case gray
    case greeen
    case lightGray
    case magenta
    case orange
    case purple
    case red
    
    var color: UIColor {
        switch self {
        case .blue:
            return .blue
        case .cyan:
            return .cyan
        case .gray:
            return .gray
        case .greeen:
            return .green
        case .lightGray:
            return .lightGray
        case .magenta:
            return.magenta
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .red:
            return .red
        }
    }
}
