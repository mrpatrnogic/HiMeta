//
//  MetafyFont.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import UIKit

public enum MetafyFontBase: CGFloat {
    case h1 = 32
    case h2 = 24
    case headline = 20
    case body = 16
    case captionOne = 14
    case captionTwo = 12
    case label = 10
    case small = 8.4
}

public struct MetafyFontCore {
    
    // MARK: - H1 font
    public var h1Light: UIFont {
        return MetafyFontCore.font(.h1, style: .light)
    }
    
    public var h1Regular: UIFont {
        return MetafyFontCore.font(.h1, style: .regular)
    }
    
    public var h1SemiBold: UIFont {
        return MetafyFontCore.font(.h1, style: .semiBold)
    }
    
    public var h1Bold: UIFont {
        return MetafyFontCore.font(.h1, style: .bold)
    }
    
    // MARK: - H2 font
    public var h2Light: UIFont {
        return MetafyFontCore.font(.h2, style: .light)
    }
    
    public var h2Regular: UIFont {
        return MetafyFontCore.font(.h2, style: .regular)
    }
    
    public var h2SemiBold: UIFont {
        return MetafyFontCore.font(.h2, style: .semiBold)
    }
    
    public var h2Bold: UIFont {
        return MetafyFontCore.font(.h2, style: .bold)
    }
    
    // MARK: - Headline font
    public var headlineLight: UIFont {
        return MetafyFontCore.font(.headline, style: .light)
    }
    
    public var headlineRegular: UIFont {
        return MetafyFontCore.font(.headline, style: .regular)
    }
    
    public var headlineSemiBold: UIFont {
        return MetafyFontCore.font(.headline, style: .semiBold)
    }
    
    public var headlineBold: UIFont {
        return MetafyFontCore.font(.headline, style: .bold)
    }
    
    // MARK: - Body font
    public var bodyLight: UIFont {
        return MetafyFontCore.font(.body, style: .light)
    }
    
    public var bodyRegular: UIFont {
        return MetafyFontCore.font(.body, style: .regular)
    }
    
    public var bodySemiBold: UIFont {
        return MetafyFontCore.font(.body, style: .semiBold)
    }
    
    public var bodyBold: UIFont {
        return MetafyFontCore.font(.body, style: .bold)
    }
    
    // MARK: - Caption One font
    public var captionOneLight: UIFont {
        return MetafyFontCore.font(.captionOne, style: .light)
    }
    
    public var captionOneRegular: UIFont {
        return MetafyFontCore.font(.captionOne, style: .regular)
    }
    
    public var captionOneSemiBold: UIFont {
        return MetafyFontCore.font(.captionOne, style: .semiBold)
    }
    
    public var captionOneBold: UIFont {
        return MetafyFontCore.font(.captionOne, style: .bold)
    }
    
    // MARK: - Caption Two font
    public var captionTwoLight: UIFont {
        return MetafyFontCore.font(.captionTwo, style: .light)
    }
    
    public var captionTwoRegular: UIFont {
        return MetafyFontCore.font(.captionTwo, style: .regular)
    }
    
    public var captionTwoSemiBold: UIFont {
        return MetafyFontCore.font(.captionTwo, style: .semiBold)
    }
    
    public var captionTwoBold: UIFont {
        return MetafyFontCore.font(.captionTwo, style: .bold)
    }
    
    // MARK: - Label font
    public var labelLight: UIFont {
        return MetafyFontCore.font(.label, style: .light)
    }
    
    public var labelRegular: UIFont {
        return MetafyFontCore.font(.label, style: .regular)
    }
    
    public var labelSemiBold: UIFont {
        return MetafyFontCore.font(.label, style: .semiBold)
    }
    
    public var labelBold: UIFont {
        return MetafyFontCore.font(.label, style: .bold)
    }
    
    public var smallSemiBold: UIFont {
        return MetafyFontCore.font(.small, style: .semiBold)
    }
}

public extension MetafyFontCore {
    static func font(_ font: MetafyFontBase, style: MetafyFontName) -> UIFont {
        UIFont.register(font: style.rawValue, withExtension: "ttf")
        
        let Metafyfont = UIFont(name: style.rawValue, size: font.rawValue)
        return Metafyfont ?? UIFont.defaultFont(size: font.rawValue)
    }
}

public enum MetafyFontName: String {
    case light = "Poppins-Light"
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
    case semiBold = "Poppins-SemiBold"
}
