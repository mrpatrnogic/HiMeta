//
//  GameListSectionController.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import IGListKit
import RxSwift
import RxRelay

final class GameListSectionController: ListSectionController, GameListActionHandler {
    private var items: [GameTile] = []
    var disposeBag = DisposeBag()
    var onActionSubject = PublishRelay<GameListUserAction>()
    var onAction: Observable<GameListUserAction> {
        return onActionSubject.asObservable()
    }
    
    override func numberOfItems() -> Int {
        return items.count
    }
    
    override func didUpdate(to object: Any) {
        if let result = object as? GameListSearchResult {
            items = result.games
        }
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width/2, height: 220.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: GameTileCell = reuse(at: index)
        cell.update(with: items[index])
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        onActionSubject.accept(.selectGame(items[index]))
    }
}
