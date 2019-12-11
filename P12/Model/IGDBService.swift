//
//  IGDBService.swift
//  P12
//
//  Created by Jordan MOREAU on 07/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

class IGDBService {
    static let igdbApiUrl = "https://api-v3.igdb.com/games/"
    
    init(questionSession: URLSession = URLSession(configuration: .default)){
        self.questionSession = questionSession
    }
    
//    let url = URL(string: "https://api-v3.igdb.com/achievement_icons")!
//    var requestHeader = URLRequest.init(url: url as! URL)
//    requestHeader.httpBody = "fields alpha_channel,animated,height,image_id,url,width;".data(using: .utf8, allowLossyConversion: false)
//    requestHeader.httpMethod = "POST"
//    requestHeader.setValue("YOUR_API_KEY", forHTTPHeaderField: "user-key")
//    requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//    URLSession.shared.dataTask(with: requestHeader) { data, response, error in }.resume()
    
    private let searchUrl = URL(string: igdbApiUrl)
    private var questionTask : URLSessionDataTask?
    private var questionSession : URLSession
    
    var apiKey = ""
    func getResult(callback: @escaping (Bool, [Game]?) -> Void){
        guard let url = searchUrl else{return}
        
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields *, cover.image_id, screenshots.image_id, age_ratings.* ; where platforms = (48,49,130) & total_rating > 70 & themes = (34) & genres = (13) & age_ratings.rating = (1,2,6,8,9); limit 100;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        questionTask?.cancel()
//        URLSession.shared.dataTask(with: requestHeader) { data, response, error in }.resume()

    
        questionTask = questionSession.dataTask(with: requestHeader) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode([Game].self, from: data) else{
                    callback(false, nil)
                    return
                    
                }
                callback(true, responseJSON)
            }
        }
        questionTask?.resume()
    }
}
