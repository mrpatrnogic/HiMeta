//
//  MetafyColor.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit

public struct MetafyColorCore {
    public let metafy: UIColor = UIColor(
        named: "metafy", in: nil, compatibleWith: nil
    ) ?? UIColor()
    
    public let background: UIColor = UIColor(
        named: "background", in: nil, compatibleWith: nil
    ) ?? UIColor()
}
