//
//  ApiKeysManager.swift
//  P12
//
//  Created by Jordan MOREAU on 16/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

final class ApiKeysManager{
    
    private static var apiKeysPlist: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else{
            fatalError("no dictionnary")
        }
        return NSDictionary(contentsOfFile: path) ?? [:]
        
    }()
    
    static var igdbApiKey: String{
        return apiKeysPlist["igdbApiKey"] as? String ?? String()
    }
}
