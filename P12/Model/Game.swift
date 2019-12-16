//
//  IGDBResults.swift
//  P12
//
//  Created by Jordan MOREAU on 08/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

//struct Game: Decodable {
//    let name: String
//
//    enum CodingKeys: String, CodingKey {
//        case name
//    }
//}
//
//typealias GameArray = [Game]

struct Game: Decodable {
    let id: Int
    let cover: Cover?
    let name: String?
    let summary: String?
    let ageRatings: [AgeRating]?
    let genres: [Int]?
    let platforms: [Int]?
    let total_rating: Double?
    let themes: [Int]?
    let gameModes: [Int]?
    let screenshots: [Cover]?
    let first_release_date: Int?
}

struct AgeRating: Decodable {
    let rating: Int?
}

struct Cover: Decodable {
    let id: Int?
    let image_id: String?
}


