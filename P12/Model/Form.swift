//
//  Form.swift
//  P12
//
//  Created by Jordan MOREAU on 12/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

enum Platform {
    case iOS
    case NextGen
    case Switch
    case PC
    case Mac
}

enum Film{
    case Horror
    case Action
    case SF
    case Comedy
    case Documentary
}

enum Character{
    case Structured
    case Fiable
    case Curious
    case Adventure
    case Bold
}

enum Preference{
    case Sport
    case Car
    case Music
    case Art
    case Enigma
}

struct Form {
    var platforms: [Int]
    var genres: [Int]
    var themes: [Int]
}

