//
//  Form.swift
//  P12
//
//  Created by Jordan MOREAU on 12/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

enum Platform: String{
    case iOS = "39"
    case NextGen = "48,49"
    case Switch = "130"
    case PC = "6,92"
    case Mac = "14"
}

enum Film: String{
    case Horror = "19,20"
    case Action = "1,39"
    case SF = "18,17"
    case Comedy = "27,35"
    case Documentary = "22,28,41"
}

enum Character: String{
    case Structured = "16,24,15"
    case Fiable = "21,23"
    case Curious = "33,43,38"
    case Adventure = "31,8,12"
    case Bold = "4,5,33,25"
}

enum Preference: String{
    case Sport = "14"
    case Car = "10"
    case Music = "7"
    case Art = "32"
    case Enigma = "9,28"
}

enum Age: String{
    case UnderSeven = "1,7"
    case SevenEleven = "1,2,7,8,9"
    case TwelveFifteen = "1,2,3,7,8,9,10"
    case SixteenHeighteen = "1,2,3,4,7,8,9,10,11"
    case Heighteen = "1,2,3,4,5,6,7,8,9,10,11,12"
    
}

struct Form {
    var platforms: [Int]
    var genres: [Int]
    var themes: [Int]
}

