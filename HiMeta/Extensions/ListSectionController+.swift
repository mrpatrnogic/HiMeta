//
//  ListSectionController+.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import IGListKit

extension ListSectionController {
    public func reuse<T: UICollectionViewCell>(at index: Int, bundle: Bundle? = nil) -> T {
        guard let context = collectionContext else { return T() }
        let cell: T = context.dequeueReusableCell(withNibName: String(describing: T.self),
                                                  bundle: nil,
                                                  for: self,
                                                  at: index) as! T
        return cell
    }
}
