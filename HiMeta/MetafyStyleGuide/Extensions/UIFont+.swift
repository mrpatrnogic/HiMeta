//
//  UIFont+.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit

public enum MetafyFontStyle {
    case light
    case regular
    case medium
    case bold
    case semiBold
    
    public func name() -> String {
        switch self {
        case .light:
            return "Poppins-Light"
        case .regular:
            return "Poppins-Regular"
        case .medium, .semiBold:
            return "Poppins-SemiBold"
        case .bold:
            return "Poppins-Bold"
        }
    }
}

public extension UIFont {
    convenience init?(_ type: MetafyFontStyle, size: CGFloat) {
        self.init(name: type.name(), size: size)
    }
    
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func register(font named: String, withExtension extensionType: String) {
        let bundle = Bundle.main
        var error: Unmanaged<CFError>? = nil
        defer { error?.release() }
        guard let url = bundle.url(forResource: named, withExtension: extensionType),
            let provider = CGDataProvider(url: url as CFURL) else { return }
        
        if let font = CGFont(provider) {
            _ = CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
