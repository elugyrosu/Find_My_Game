//
//  String.swift
//  P12
//
//  Created by Jordan MOREAU on 25/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

extension String{
    /// Transform string url to data
    var data: Data? {
        guard let url = URL(string: self) else{return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
