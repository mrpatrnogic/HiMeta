//
//  GameListNetworkerTests.swift
//  HiMetaTests
//
//  Created by Marcio Romero on 1/19/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
import OHHTTPStubs
@testable import HiMeta

class GameListNetworkerTests: XCTestCase {
    private var disposeBag = DisposeBag()
    
    override class func tearDown() {
        NetworkStub.instance.removeStubs()
        super.tearDown()
    }
    
    func test_fetchGames_success() {
        let networker: GameListNetworkerProtocol = GameListNetworker()
        let urlPattern = "indexes/games/search"
        NetworkStub.instance.defaultStub(urlEndsWith: urlPattern,
                                         jsonMock: "searchGames",
                                         type: GameListNetworkerTests.self)
        let json = try? networker.fetchGames(query: "",
                                             offset: 0,
                                             limit: 0,
                                             filters: "").toBlocking(timeout: 2.0).first()
        
        NetworkStub.instance.removeStubs()
        let query: String? = json?["query"] as? String
        XCTAssertEqual(query, "metafy")
    }
    
    func test_fetchGames_failure() {
        let networker: GameListNetworkerProtocol = GameListNetworker()
        let urlPattern = "indexes/games/search"
        NetworkStub.instance.defaultStubServerDown(urlEndsWith: urlPattern)
        let json = try? networker.fetchGames(query: "",
                                             offset: 0,
                                             limit: 0,
                                             filters: "").toBlocking(timeout: 2.0).first()
        
        NetworkStub.instance.removeStubs()
        let query: String? = json?["query"] as? String
        XCTAssertNil(query)
    }
}
