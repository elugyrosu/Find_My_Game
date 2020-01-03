//
//  Form.swift
//  P12
//
//  Created by Jordan MOREAU on 12/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import Foundation

// id for API requests

enum Age: String{
    case UnderSeven = "1,7"
    case SevenEleven = "1,2,7,8,9"
    case TwelveFifteen = "1,2,3,7,8,9,10"
    case SixteenHeighteen = "1,2,3,4,7,8,9,10,11"
    case Heighteen = "1,2,3,4,5,6,7,8,9,10,11,12"
}

enum Platform: String{
    case PS4  = "48"
    case XOne = "49"
    case iOS = "39"
    case NextGen = "48,49"
    case Switch = "130"
    case PC = "6,92"
    case Mac = "14"
    case VR = "165"
    case All = "48,49,39,130,6,92,14,165,162,163"
}

enum Film: String{
    case Horror = "19,20"
    case Action = "1,39"
    case SF = "18,17"
    case Comedy = "27,35"
    case Documentary = "22,28,41"
}

enum Character: String{
    case Stealth = "23"
    case Creator = "33"
    case Explorer = "38"
    case Survival = "21"
    case Mystery = "43"
}

enum WeekEnd: String{
    case Nature = "31,8"
    case Party = "5,33"
    case Plate = "16,15,13"
    case Book = "12,24"
    case Sport = "4,25"
}

enum Preference: String{
    case Sport = "14"
    case Car = "10"
    case Music = "7"
    case Art = "32"
    case Enigma = "9,28"
}

enum GameMode: String{
    case SplitScreen = "4"
    case Multiplayer = "2"
    case Coop = "3"
}

enum Players: String{
    case TwoPlayer = "= 2"
    case FourPlayer = "> 2"
    case More = "> 4"
}

enum Coop: String{
    case True = "true"
    case False = "false"
}

enum Rating: String{
    case Ten = "10"
    case Fifty = "50"
    case Sixty = "60"
    case Seventy = "70"
    case Heigty = "80"
    case Ninety = "90"
}
