//
//  Model.swift
//  TVChannelsSwiftUICombine
//
//  Created by Дмитрий Фёдоров on 17.01.2022.
//

import SwiftyJSON

struct Channel: Codable, Identifiable {
    let orderNum: Int
    let accessNum: Int
    let callSign: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case orderNum, accessNum, id
        case callSign = "CallSign"
    }
}

struct ProgramItem: Codable {
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case startTime
        case recentAirTime
        case length
        case name
    }
}

struct RecentAirTime: Codable {
    let id, channelID: Int
}


