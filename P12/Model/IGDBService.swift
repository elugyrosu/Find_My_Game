//
//  IGDBService.swift
//  P12
//
//  Created by Jordan MOREAU on 07/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class IGDBService {
    private let igdbApiUrl = "https://api-v3.igdb.com/games/"
    
    init(questionSession: URLSession = URLSession(configuration: .default)){
        self.questionSession = questionSession
    }
    

    private lazy var searchUrl = URL(string: igdbApiUrl)
    private var questionTask : URLSessionDataTask?
    private var questionSession : URLSession
    
    var apiKey = ApiKeysManager.igdbApiKey
    
    enum NetworkError: Error {
        case badURL
        case decodeError
        case dataError
        
    }
    
    func getResult(platforms: String, themes: String, genres: String, ageRating: String, callback: @escaping (Result<[Game], Error>) -> Void){
        guard let url = searchUrl else{
            callback(.failure(NetworkError.badURL))
            return
        }
        
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields *, cover.image_id, screenshots.image_id, age_ratings.* ; where platforms = (\(platforms)) & total_rating > 50 & themes = (\(themes)) & genres = (\(genres)) & age_ratings.rating = (\(ageRating)); limit 100;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")

        questionTask = questionSession.dataTask(with: requestHeader) { (data, response, error) in
            DispatchQueue.main.async {

            if let error = error {
                callback(.failure(error))
                return
            }
            guard let data = data else {
                callback(.failure(NetworkError.dataError))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode([Game].self, from: data) else{
                callback(.failure(NetworkError.decodeError))
                return
            }
            callback(.success(responseJSON))
        }
        }
        questionTask?.resume()
        
    }
}
