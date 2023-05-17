//
//  FontManager.swift
//  HUSTLE HARD
//
//  Created by Tilan on 14/5/23.
//

import Foundation
import UIKit

enum CustomFont: String {
    case blackItalic = "Poppins-BlackItalic"
    case bold = "Poppins-Bold"
    case extraLight = "Poppins-ExtraLight"
    case italic = "Poppins-Italic"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semiBold = "Poppins-SemiBold"
}

final class FontManager {
    static let shared = FontManager()

    private init() {}

    func customFont(_ font: CustomFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
            fatalError("Failed to load the \(font.rawValue) font.")
        }
        return customFont
    }
}
