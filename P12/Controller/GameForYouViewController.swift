//
//  GameForYouViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 13/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class GameForYouViewController: UIViewController {
    
    // MARK: Properties

    private let igdbService = IGDBService()
    private var gameList = [Game]()

    private var platformAnswer = Platform.NextGen
    private var filmAnswer = Film.Action
    private var preferenceAnswer = Preference.Art
    private var characterAnswer = Character.Creator
    private var ageAnswer = Age.Heighteen
    private var weekEndAnswer = WeekEnd.Nature
    
    // MARK: Outlets
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet var platformAnswerButtons: [UIButton]!
    @IBOutlet var filmAnswerButtons: [UIButton]!
    @IBOutlet var characterAnswerButtons: [UIButton]!
    @IBOutlet var preferenceAnswerButtons: [UIButton]!
    @IBOutlet var ageAnswerButtons: [UIButton]!
    @IBOutlet var weekEndAnswerButtons: [UIButton]!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        buttonsInitialization()
    }
    
    // MARK: Action Button Outlet

    @IBAction func discoverButtonAction(_ sender: Any) {
        gamesCall(platforms: platformAnswer.rawValue, themes: filmAnswer.rawValue + "," + characterAnswer.rawValue, genres: preferenceAnswer.rawValue + "," + weekEndAnswer.rawValue, ageRating: ageAnswer.rawValue)
    }
    
    // MARK: Action Button Methods

    func buttonsInitialization(){
        ageAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(ageAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        platformAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(platformAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        filmAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(filmAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        characterAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(characterAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        weekEndAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(weekEndAnswerButtonTapped(_:)), for: .touchUpInside)
        }
        preferenceAnswerButtons.forEach { button in
            button.addTarget(self, action: #selector(preferenceAnswerButtonTapped(_:)), for: .touchUpInside)
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
            characterAnswer = .Stealth
        case 2:
            characterAnswer = .Creator
        case 3:
            characterAnswer = .Explorer
        case 4:
            characterAnswer = .Survival
        case 5:
            characterAnswer = .Mystery
        default:
            print("Tag character Error")
        }
    }
    
    @objc func weekEndAnswerButtonTapped(_ sender: UIButton) {
        weekEndAnswerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            weekEndAnswer = .Party
        case 2:
            weekEndAnswer = .Sport
        case 3:
            weekEndAnswer = .Nature
        case 4:
            weekEndAnswer = .Plate
        case 5:
            weekEndAnswer = .Book
        default:
            print("Tag week end Error")
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

    // MARK: Class Methods
    
    private func toggleActivityIndicator(shown: Bool){
        activityIndicatorView.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    private func gamesCall(platforms: String, themes: String, genres: String, ageRating: String) {
        toggleActivityIndicator(shown: true)
        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; where platforms = (\(platforms)) & total_rating > 70 & themes = (\(themes)) & genres = (\(genres)) & age_ratings.rating = (\(ageRating)); limit 100;"
        igdbService.getResult(httpBody: httpBodyString) { result in
            self.toggleActivityIndicator(shown: false)
            switch result {
            case .success(let data):
                self.gameList = data
                if data.count >= 1{
                    self.performSegue(withIdentifier: "segueToCollectionViewController", sender: self)
                }else{
                    self.presentAlert(message: "We have no results for your search")
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presentAlert(message: "Network error")
            }
        }
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCollectionViewController" {
            guard let resultVC = segue.destination as? CollectionViewController else{return}
            resultVC.gameList = gameList
        }
    }
}

// MARK: UIScrollViewDelegate

extension GameForYouViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/7), animated: false)
    }
}
