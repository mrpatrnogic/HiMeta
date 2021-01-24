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
    var shouldFetchMoreItems: Bool { get }
    func fetchGames(query: String) -> Completable
    func fetchMoreItems() -> Completable
}

final class GameListInteractor: GameListInteractorProtocol {
    private let networker: GameListNetworkerProtocol
    private let pagingSize: Int = 20
    private var offset: Int = 0
    private var lastQuery: String = ""
    private var filters: String = "coach_count >= 1"
    var searchResult: GameListSearchResult?
    var fetchLimit: Int = 0
    var shouldFetchMoreItems: Bool {
        let itemCount = searchResult?.games.count ?? 0
        return itemCount > fetchLimit - pagingSize / 2
    }
    
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
    
    func fetchMoreItems() -> Completable {
        let gameCount = searchResult?.games.count ?? 0
        fetchLimit = gameCount + pagingSize
        return networker
            .fetchGames(query: lastQuery, offset: gameCount, limit: pagingSize, filters: filters)
            .map { [weak self] (data) -> GameListSearchResult? in
                guard let newResults = GameListSearchResult(JSON: data) else { return self?.searchResult }
                self?.searchResult?.games.append(contentsOf: newResults.games)
                return self?.searchResult
            }
            .asCompletable()
    }
}

