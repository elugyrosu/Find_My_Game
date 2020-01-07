//
//  SearchViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 19/11/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties

    private let igdbService = IGDBService()
    private var gameList = [Game]()
    private var ageAnswer = Age.Heighteen
    private var rating = Rating.Ten
    private var platformAnswer = Platform.All
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet var platformButtons: [UIButton]!
    @IBOutlet var ageButtons: [UIButton]!
    @IBOutlet var scoreButtons: [UIButton]!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        // Do any additional setup after loading the view.
        scoreButtons.forEach { button in
            button.layer.cornerRadius = 13
            button.layer.masksToBounds = true
        }
        platformButtons.forEach { button in
            button.layer.cornerRadius = 13
            button.layer.masksToBounds = true
        }
        ageButtons.forEach { button in
            button.layer.cornerRadius = 13
            button.layer.masksToBounds = true
        }
        searchButton.layer.cornerRadius = 13
        searchButton.layer.masksToBounds = true
    }

    // MARK: - Action Button Outlets

    @IBAction func platformButtonTapped(_ sender: UIButton) {
        platformButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true

            switch sender.tag {
            case 1:
                platformAnswer = .PS4
            case 2:
                platformAnswer = .XOne
            case 3:
                platformAnswer = .Switch
            case 4:
                platformAnswer = .PC
            case 5:
                platformAnswer = .Mac
            case 6:
                platformAnswer = .iOS
            case 7:
                platformAnswer = .VR
                
            default:
                print("Tag platform Error")
            }
    }
    
    @IBAction func ageButonTapped(_ sender: UIButton) {
        ageButtons.forEach { button in
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
    
    @IBAction func scoreButtonTapped(_ sender: UIButton) {
        scoreButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            rating = .Fifty
        case 2:
            rating = .Sixty
        case 3:
            rating = .Seventy
        case 4:
            rating = .Heigty
        case 5:
            rating = .Ninety
        default:
            print("Tag score Error")
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        gamesCall()
    }
    
    // MARK: - Class Methods

    private func toggleActivityIndicator(shown: Bool){
        activityIndicatorView.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    private func bodyConstruction() -> String{
        var searchBody = ""
        guard let searchString = searchBar.text else {
            return ""
        }
        if searchString != "" {
            searchBody = "search \u{22}\(searchString)\u{22}; "
        }
        let httpBodyString = searchBody + "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; where platforms = (\(platformAnswer.rawValue)) & age_ratings.rating = (\(ageAnswer.rawValue)) & total_rating > \(rating.rawValue)" + "; limit 100;"
        return httpBodyString
    }
    
    private func gamesCall() {
        toggleActivityIndicator(shown: true)
        let httpBodyString = bodyConstruction()

        igdbService.getResult(httpBody: httpBodyString) { result in
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false)
                switch result {
                case .success(let data):
                    self.gameList = data
                    if data.count >= 1{
                        self.performSegue(withIdentifier: "segueToCollectionViewController", sender: self)
                    }else{
                        self.presentAlert(message: "Nous n'avons aucun jeu à vous proposer")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.presentAlert(message: "Network error")
                }
            }
        }
    }
    
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCollectionViewController" {
            guard let resultVC = segue.destination as? CollectionViewController else{return}
            resultVC.gameList = gameList
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate{
    @IBAction func dismissedKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    func searchBarshouldReturn(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
}
