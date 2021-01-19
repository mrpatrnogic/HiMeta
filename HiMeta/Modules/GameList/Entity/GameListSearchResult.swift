//
//  GameListSearchResult.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import ObjectMapper
import IGListDiffKit

final class GameListSearchResult: NSObject, Mappable {
    var games: [GameTile] = []
    var query: String = ""

    required init?(map: Map) { }

    func mapping(map: Map) {
        games <- map["hits"]
        query <- map["query"]
    }
}


extension GameListSearchResult: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return query as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let rightItem = object as? GameListSearchResult else {
            return false
        }
        return query == rightItem.query
    }
}
