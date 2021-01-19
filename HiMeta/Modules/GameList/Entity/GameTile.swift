//
//  GameTile.swift
//  HiMeta
//
//  Created by Marcio Romero on 1/18/21.
//

import Foundation
import ObjectMapper

final class GameTile: Mappable {
    var gameId: String = ""
    var title: String = ""
    var poster: String = ""
    var artwork: String = ""
    var lessonCount: Int = 0
    var coachCount: Int = 0

    init() { }
    required init?(map: Map) { }

    func mapping(map: Map) {
        gameId <- map["id"]
        title <- map["title.en"]
        poster <- map["poster"]
        artwork <- map["artwork"]
        lessonCount <- map["package_count"]
        coachCount <- map["coach_count"]
    }
}
