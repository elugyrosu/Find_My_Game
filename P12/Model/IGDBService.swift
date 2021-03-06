//
//  IGDBService.swift
//  P12
//
//  Created by Jordan MOREAU on 07/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class IGDBService {
    
    // MARK: - Properties

    private let igdbApiUrl = "https://api-v3.igdb.com/games/"
    
    init(questionSession: URLSession = URLSession(configuration: .default)){
        self.questionSession = questionSession
    }
    
    private lazy var searchUrl = URL(string: igdbApiUrl)
    private var questionTask : URLSessionDataTask?
    private var questionSession : URLSession
    
    var apiKey = ApiKeys.igdbApiKey
    
    enum NetworkError: Error {
        case badURL
        case decodeError
        case dataError
    }
    
    // MARK: - Class Method
    
    /// API request with Result() type
    func getResult(httpBody: String, callback: @escaping (Result<[Game], Error>) -> Void){
        guard let url = searchUrl else{
            callback(.failure(NetworkError.badURL))
            return
        }
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBody.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        questionTask = questionSession.dataTask(with: requestHeader) { (data, response, error) in
            
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let data = data else {
                callback(.failure(NetworkError.dataError))
                return
            }
            do {
                let responseJSON = try JSONDecoder().decode([Game].self, from: data)
                callback(.success(responseJSON))
            }catch{
                print(error.localizedDescription)
                callback(.failure(NetworkError.decodeError))
            }
        }
        
        questionTask?.resume()
        
    }
}
