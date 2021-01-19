//
//  GameListPresenter.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import RxSwift
import IGListKit

enum GameListUIEvent {
    case reloadData
    case showError(_ error: Error)
    case showLoader(_ show: Bool)
}

enum GameListUserAction {
    case requestMoreItems
    case selectGame(_ game: GameTile)
}

protocol GameListPresenterProtocol: GameListDataSourceDelegate {
    var onUIEvent: Observable<GameListUIEvent> { get }
    func presentGameList()
    func fetchGames(query: String)
}

final class GameListPresenter: GameListPresenterProtocol {
    private let interactor: GameListInteractorProtocol
    private let router: GameListRouterProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    private let onUIEventSubject = PublishSubject<GameListUIEvent>()
    var onUIEvent: Observable<GameListUIEvent> {
        return onUIEventSubject.asObservable()
    }
    private let onUserActionSubject = PublishSubject<GameListUIEvent>()
    var onUserAction: Observable<GameListUIEvent> {
        return onUserActionSubject.asObservable()
    }
    
    init(interactor: GameListInteractorProtocol,
         router: GameListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func presentGameList() {
        router.showGameList(with: self)
    }
    
    var data: [ListDiffable] {
        var items: [ListDiffable] = []
        if let result = interactor.searchResult {
            items.append(result)
        }
        return items
    }
    
    func setupObserverToHandleAction(for section: GameListActionHandler) {
        section
            .onAction
            .subscribe(onNext: { [weak self] action in
                guard let self = self else { return }
                switch action {
                case .selectGame(let game):
                    self.openGameDetail(game)
                case .requestMoreItems:
                    break
                }
            }).disposed(by: section.disposeBag)
    }
    
    func fetchGames(query: String) {
        interactor
            .fetchGames(query: query).subscribe(onCompleted: { [weak self] in
                self?.onUIEventSubject.onNext(.showLoader(false))
                self?.onUIEventSubject.onNext(.reloadData)
            }, onError: { [weak self] (error) in
                self?.onUIEventSubject.onNext(.showLoader(false))
                self?.onUIEventSubject.onNext(.showError(error))
            })
            .disposed(by: disposeBag)
    }
    
    func openGameDetail(_ game: GameTile) {
        print(game.gameId)
    }
}
