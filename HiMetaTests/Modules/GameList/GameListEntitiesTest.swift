//
//  GameListEntitiesTest.swift
//  HiMetaTests
//
//  Created by Marcio Romero on 1/19/21.
//

import XCTest
@testable import HiMeta

class GameListEntitiesTest: XCTestCase {
    func test_gameListSearchResult() {
        let json: [String: Any] = ["hits": [[:]],
                                   "query": "metafy"]
        let searchResults = GameListSearchResult(JSON: json)
        
        XCTAssertEqual(searchResults?.query, "metafy")
        XCTAssertEqual(searchResults?.games.count, 1)
    }
    
    func test_gameTile() {
        let json: [String: Any] = ["id": "mockId",
                                   "title": ["en": "mockTitle"],
                                   "poster": "posterUrl",
                                   "artwork": "artworkUrl",
                                   "package_count": 69,
                                   "coach_count": 420]
        let tile = GameTile(JSON: json)
        
        XCTAssertEqual(tile?.gameId, "mockId")
        XCTAssertEqual(tile?.title, "mockTitle")
        XCTAssertEqual(tile?.poster, "posterUrl")
        XCTAssertEqual(tile?.artwork, "artworkUrl")
        XCTAssertEqual(tile?.lessonCount, 69)
        XCTAssertEqual(tile?.coachCount, 420)
    }
}
