//
//  FakeResponseData.swift
//  P12Tests
//
//  Created by Jordan MOREAU on 28/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "igdbResponse", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectData = "erreur".data(using: .utf8)!
}
