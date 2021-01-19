//
//  GameListInteractor.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import RxSwift

protocol GameListInteractorProtocol {
    var searchResult: GameListSearchResult? { get }
    func fetchGames(query: String) -> Completable
}

final class GameListInteractor: GameListInteractorProtocol {
    private let networker: GameListNetworkerProtocol
    private let pagingSize: Int = 20
    private var offset: Int = 0
    private var lastQuery: String = ""
    private var filters: String = "coach_count >= 1"
    var searchResult: GameListSearchResult?
    
    init(networker: GameListNetworkerProtocol) {
        self.networker = networker
    }
    
    func fetchGames(query: String) -> Completable {
        lastQuery = query
        return networker
            .fetchGames(query: query, offset: offset, limit: pagingSize, filters: filters)
            .map { [weak self] (data) -> GameListSearchResult? in
                self?.searchResult = GameListSearchResult(JSON: data)
                return self?.searchResult
            }
            .asCompletable()
    }
}

