//
//  GameListRouter.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import UIKit

protocol GameListRouterProtocol {
    func showGameList(with presenter: GameListPresenterProtocol)
}

final class GameListRouter: GameListRouterProtocol {
    private weak var navigationController: UINavigationController?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func showGameList(with presenter: GameListPresenterProtocol) {
        let view = GameListViewController(presenter: presenter)
        navigationController?.pushViewController(view, animated: true)
    }
}
