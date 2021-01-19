//
//  GameListModule.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit

protocol GameListModuleType {
    func showGameList()
}

final class GameListModule: GameListModuleType {
    private let presenter: GameListPresenterProtocol
    init(with navigationController: UINavigationController) {
        let router = GameListRouter(navigation: navigationController)
        let networker = GameListNetworker()
        let interactor = GameListInteractor(networker: networker)
        let presenter = GameListPresenter(interactor: interactor,
                                          router: router)
        self.presenter = presenter
    }
    
    func showGameList() {
        presenter.presentGameList()
    }
}
