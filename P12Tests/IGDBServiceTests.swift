//
//  IGDBServiceTests.swift
//  P12Tests
//
//  Created by Jordan MOREAU on 28/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import XCTest
@testable import P12

class IGDBServiceTests: XCTestCase {

    func testRequestMethod_whenErrorIsPassed_ThenShouldReturnAFailedCallback(){
        let urlSessionFake = URLSessionFake(data: nil, response: nil, error: FakeResponseData.networkError)
        let igdbService = IGDBService(questionSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "wait for queue change.")
        igdbService.getResult(httpBody: "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; limit 100;"){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRequestMethod_whenIncorrectData_ThenShouldReturnAFailedCallback(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)
        let igdbService = IGDBService(questionSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "wait for queue change.")
        igdbService.getResult(httpBody: "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; limit 100;"){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRequestMethod_whenCorrectDataAndResponseKO_ThenShouldReturnAFailedCallback(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: nil)
        let igdbService = IGDBService(questionSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "wait for queue change.")
        igdbService.getResult(httpBody: "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; limit 100;"){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

//    func testRequestMethod_whenCorrectDataAndResponseArePassed_ThenShouldReturnASucceededCallback(){
//        let urlSessionFake = URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil)
//        let igdbService = IGDBService(questionSession: urlSessionFake)
//        let expectation = XCTestExpectation(description: "wait for queue change.")
//        igdbService.getResult(httpBody: "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; limit 100;"){ result in
//            guard case .success(let results) = result else {
//                XCTFail("Test request method with an error failed.")
//                return
//            }
//            XCTAssertNotNil(results[0].name)
//            XCTAssertEqual(results[0].name, "Moondust: Knuckles Tech Demos")
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }

}
