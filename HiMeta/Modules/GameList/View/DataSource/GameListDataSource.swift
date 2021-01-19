//
//  GameListDataSource.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import IGListKit
import RxSwift

protocol GameListActionHandler {
    var onAction: Observable<GameListUserAction> { get }
    var disposeBag: DisposeBag { get }
}

protocol GameListDataSourceDelegate: AnyObject {
    var data: [ListDiffable] { get }
    func setupObserverToHandleAction(for section: GameListActionHandler)
}

final class GameListDataSource: NSObject, ListAdapterDataSource {
    weak var delegate: GameListDataSourceDelegate?
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return delegate?.data ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GameListSearchResult:
            let controller = GameListSectionController()
            return controller
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
