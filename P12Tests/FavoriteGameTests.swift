//
//  FavoriteGameTests.swift
//  P12Tests
//
//  Created by Jordan MOREAU on 29/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import XCTest
import CoreData
@testable import P12

class FavoriteGameTests: XCTestCase {

    //MARK: - Properties
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGame")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    //MARK: - Helper Methods
    
    private func addGame(into managedObjectContext: NSManagedObjectContext) {
        let favoriteGame = FavoriteGame(context: managedObjectContext)
        favoriteGame.id = "12567"
    }
    
    //MARK: - Unit Tests
    
    func testInsertManyFavoriteGamesItemsInPersistentContainer() {
        for _ in 0 ..< 100000 {
            addGame(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testAddFavoriteGameItemInPersistentContainer() {
        let cover = Cover(id: 123, image_id: "123")
        let platfotm = Genre(name: "ps4")
        let game = Game(id: 12567, cover: Cover(id: 0, image_id: ""), name: "", summary: "", genres: [Genre](), platforms: [platfotm], total_rating: 2345.0, themes: [Genre](), screenshots: [cover], first_release_date: 2)
        FavoriteGame.addGame(game: game, viewContext: mockContainer.viewContext)
    
        try? mockContainer.viewContext.save()
        XCTAssertEqual(FavoriteGame.fetchAll(viewContext: mockContainer.viewContext)[0].id, "12567" )
        FavoriteGame.deleteGame(gameId: "12567", viewContext: mockContainer.viewContext)
    }
    
    func testExisting(){
        let game = Game(id: 12567, cover: Cover(id: 0, image_id: ""), name: "", summary: "", genres: [Genre](), platforms: [Genre](), total_rating: 2345.0, themes: [Genre](), screenshots: [Cover](), first_release_date: 2)
        FavoriteGame.addGame(game: game, viewContext: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        XCTAssertTrue(FavoriteGame.checkIfAlreadyExist(gameId: "12567", viewContext: mockContainer.viewContext))
        FavoriteGame.deleteGame(gameId: "12567", viewContext: mockContainer.viewContext)
    }
    
    func testDelete(){
        addGame(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        
        try? mockContainer.viewContext.save()
        FavoriteGame.deleteGame(gameId: "12567", viewContext: mockContainer.viewContext)
        XCTAssertFalse(FavoriteGame.checkIfAlreadyExist(gameId: "12567", viewContext: mockContainer.viewContext))
    }
    
    
    func testDeleteFavoriteGameItemInPersistentContainer() {
        let game = Game(id: 12567, cover: Cover(id: 0, image_id: ""), name: "", summary: "", genres: [Genre](), platforms: [Genre](), total_rating: 2345.0, themes: [Genre](), screenshots: [Cover](), first_release_date: 2)

        FavoriteGame.addGame(game: game, viewContext: mockContainer.viewContext)

        try? mockContainer.viewContext.save()
        FavoriteGame.deleteGame(gameId: "12567", viewContext: mockContainer.viewContext)
        XCTAssertFalse(FavoriteGame.checkIfAlreadyExist(gameId: "12567", viewContext: mockContainer.viewContext))
    }

}
