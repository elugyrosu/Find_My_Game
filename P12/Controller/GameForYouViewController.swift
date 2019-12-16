//
//  GameForYouViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 13/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class GameForYouViewController: UIViewController {
    
    private let igdbService = IGDBService()
    private var gameList = [Game]()
    private var gameListCount = 0
    
    var platformAnswer = Platform.NextGen
    var filmAnswer = Film.Action
    var preferenceAnswer = Preference.Art
    var characterAnswer = Character.Adventure
    var ageAnswer = Age.Heighteen
    
    var genres = [Int]()
    
    @IBOutlet var platformAnswerButtons: [UIButton]!
    @IBOutlet var filmAnswerButtons: [UIButton]!
    @IBOutlet var characterAnswerButtons: [UIButton]!
    @IBOutlet var preferenceAnswerButtons: [UIButton]!
    @IBOutlet var ageAnswerButtons: [UIButton]!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    func buttonsInitialization(){
        platformAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(platformAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        filmAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(filmAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        characterAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(characterAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        preferenceAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(preferenceAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        ageAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(ageAnswerButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func platformAnswerButtonTapped(_ sender: UIButton) {
        platformAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            platformAnswer = .iOS
        case 2:
            platformAnswer = .Mac
        case 3:
            platformAnswer = .NextGen
        case 4:
            platformAnswer = .Switch
        case 5:
            platformAnswer = .PC
        default:
            print("Tag platform Error")
        }
    }
    @objc func filmAnswerButtonTapped(_ sender: UIButton) {
        filmAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            filmAnswer = .Horror
        case 2:
            filmAnswer = .Action
        case 3:
            filmAnswer = .SF
        case 4:
            filmAnswer = .Comedy
        case 5:
            filmAnswer = .Documentary
        default:
            print("Tag film Error")
        }
    }
    @objc func characterAnswerButtonTapped(_ sender: UIButton) {
        
        characterAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            characterAnswer = .Structured
        case 2:
            characterAnswer = .Fiable
        case 3:
            characterAnswer = .Curious
        case 4:
            characterAnswer = .Adventure
        case 5:
            characterAnswer = .Bold
        default:
            print("Tag character Error")
        }
    }
    @objc func preferenceAnswerButtonTapped(_ sender: UIButton) {
        preferenceAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            preferenceAnswer = .Sport
        case 2:
            preferenceAnswer = .Car
        case 3:
            preferenceAnswer = .Music
        case 4:
            preferenceAnswer = .Art
        case 5:
            preferenceAnswer = .Enigma
        default:
            print("Tag preference Error")
        }
    }
    @objc func ageAnswerButtonTapped(_ sender: UIButton) {
        ageAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            ageAnswer = .UnderSeven
        case 2:
            ageAnswer = .SevenEleven
        case 3:
            ageAnswer = .TwelveFifteen
        case 4:
            ageAnswer = .SixteenHeighteen
        case 5:
            ageAnswer = .Heighteen
        default:
            print("Tag age Error")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsInitialization()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func discoverButtonAction(_ sender: Any) {
        gamesCall(platforms: platformAnswer.rawValue, themes: filmAnswer.rawValue, genres: preferenceAnswer.rawValue, ageRating: ageAnswer.rawValue)
    }

    
    
    private func gamesCall(platforms: String, themes: String, genres: String, ageRating: String) {
        igdbService.getResult(platforms: platforms, themes: themes, genres: genres, ageRating: ageRating) { success, igdbResults in
            if success {
                guard let games = igdbResults else { return }
                self.gameList = games
                print(self.gameList)
                self.gameListCount = games.count
                if self.gameListCount >= 1{
                    self.performSegue(withIdentifier: "segueToCollectionViewController", sender: self)
                }else{
                    self.presentAlert(message: "We have no recipe for your search, check your ingredients")
                }
            }else{
                self.presentAlert(message: "Network error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCollectionViewController" {
            guard let resultVC = segue.destination as? CollectionViewController else{return}
            resultVC.gameList = gameList
        }
    }
}

extension GameForYouViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/6), animated: false)
    }
}
