//
//  FavoriteGame.swift
//  P12
//
//  Created by Jordan MOREAU on 22/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation
import CoreData

class FavoriteGame: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [FavoriteGame] {
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let gameList = try? viewContext.fetch(request) else { return [] }
        return gameList
    }
    
    static func deleteGame(gameId: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        FavoriteGame.fetchAll(viewContext: viewContext).forEach({
            if $0.id == gameId{
                viewContext.delete($0)
            }
             })
        try? viewContext.save()
    }

    static func addGame(game: Game, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favoriteGame = FavoriteGame(context: viewContext)
        favoriteGame.id = String(game.id)
        if let coverId = game.cover?.image_id {
            favoriteGame.cover = coverId
        }
        favoriteGame.name = game.name
        if let totalRating = game.total_rating {
            favoriteGame.totalRating = String(Int(totalRating))
        }
        
        if let firstReleaseDate = game.first_release_date{
            var strDate = "undefined"
            let unixTime = Double(firstReleaseDate)
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd MMM yyyy"
            strDate = dateFormatter.string(from: date)
            favoriteGame.releaseDate = strDate
        }
        if let summary = game.summary {
            favoriteGame.summary = summary
        }
        var platforms = [String]()
        game.platforms.forEach { platform in
            platforms.append(platform.name)
        }
        favoriteGame.platforms = platforms as [NSString]?
        
        var screenshots = [String]()
        game.screenshots?.forEach{ screenshot in
            screenshots.append(screenshot.image_id)
        }
        favoriteGame.screenshots = screenshots as [NSString]?
        try? viewContext.save()
    }
    
    static func checkIfAlreadyExist(gameId: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool{
        var value = false
        
        FavoriteGame.fetchAll(viewContext: viewContext).forEach({
            if $0.id == gameId{
                value = true
            }
        })
        return value
    }
}
