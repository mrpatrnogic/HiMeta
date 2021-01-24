//
//  GameListInteractorTests.swift
//  HiMetaTests
//
//  Created by Marcio Romero on 1/19/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import HiMeta

class GameListInteractorTests: XCTestCase {
    private typealias SUTest = (interactor: GameListInteractorProtocol,
                                networker: NetworkerSpy)

    private var sut: SUTest!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        let networker = NetworkerSpy()
        let interactor = GameListInteractor(networker: networker)
        sut = (interactor: interactor, networker: networker)
    }
    
    func test_fetchGames_success() {
        let interactor = sut.interactor
        let networker = sut.networker
        networker.shouldSucceed = true
        
        let result = interactor.fetchGames(query: "").toBlocking(timeout: 2.0).materialize()
        var success = false
        switch result {
        case .completed:
            success = true
        default:
            break
        }
        
        let searchResult = interactor.searchResult
        XCTAssert(success)
        XCTAssertNotNil(searchResult)
    }
    
    func test_fetchGames_failure() {
        let interactor = sut.interactor
        let networker = sut.networker
        networker.shouldSucceed = false
        
        let result = interactor.fetchGames(query: "").toBlocking(timeout: 2.0).materialize()
        var failure = false
        switch result {
        case .failed:
            failure = true
        default:
            break
        }
        
        XCTAssert(failure)
    }
    
    func test_shouldFetchMoreItems() {
        let interactor = sut.interactor
        let shouldFetchItems_before = interactor.shouldFetchMoreItems
        _ = interactor.fetchMoreItems().toBlocking(timeout: 2.0)
        let shouldFetchItems_after = interactor.shouldFetchMoreItems
        
        XCTAssertEqual(shouldFetchItems_before, true)
        XCTAssertEqual(shouldFetchItems_after, false)
    }
    
    func test_fetchMoreItems() {
        let interactor = sut.interactor
        let networker = sut.networker
        networker.fetchCount = 0
        
        _ = interactor.fetchMoreItems().toBlocking(timeout: 2.0)
        
        XCTAssertEqual(networker.fetchCount, 1)
    }
    

    private class NetworkerSpy: GameListNetworkerProtocol {
        var shouldSucceed = false
        var fetchCount = 0
        func fetchGames(query: String, offset: Int, limit: Int, filters: String) -> Single<[String : Any]> {
            fetchCount += 1
            return shouldSucceed ? .just([:]) : .error(TestError())
        }
    }
    
    private class TestError: Error {}
}
