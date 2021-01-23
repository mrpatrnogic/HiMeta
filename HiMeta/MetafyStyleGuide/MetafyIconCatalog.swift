//
//  MetafyIconCatalog.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/23/21.
//

import UIKit

public enum MetafyIconCatalog: String {
    case search = "searchIcon"
    
    public func make() -> UIImage {
        return UIImage(named: rawValue) ?? UIImage()
    }
}
