//
//  IGDBResults.swift
//  P12
//
//  Created by Jordan MOREAU on 08/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation


struct Game: Decodable {
    let id: Int
    let cover: Cover?
    let name: String
    let summary: String?
    let genres: [Genre]?
    let platforms: [Genre]
    let total_rating: Double?
    let themes: [Genre]?
    let screenshots: [Cover]?
    let first_release_date: Int?
}


struct Cover: Decodable {
    let id: Int
    let image_id: String
}

struct Genre: Decodable {
    let name: String
}
