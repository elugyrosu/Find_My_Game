//
//  PartyViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 19/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class MultiplayerViewController: UIViewController {
    
    // MARK: Properties
    
    private let igdbService = IGDBService()
    private var gameList = [Game]()
    private var platformAnswer = Platform.PS4
    private var playersAnswer = Players.TwoPlayer
    private var coopAnswer = Coop.False
    
    // MARK: Outlets
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var platformButtons: [UIButton]!
    @IBOutlet var playerButtons: [UIButton]!
    @IBOutlet var coopModeButtons: [UIButton]!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Action Button Outlets
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        gamesCall(platform: platformAnswer.rawValue, players: playersAnswer.rawValue, coop: coopAnswer.rawValue)
    }
    
    @IBAction func platformButtonsTapped(_ sender: UIButton) {
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
        default:
            print("Tag platform Error")
        }
    }
    
    @IBAction func playerButtonTapped(_ sender: UIButton) {
        playerButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            playersAnswer = .TwoPlayer
        case 2:
            playersAnswer = .FourPlayer
        case 3:
            playersAnswer = .More
        default:
            print("Tag playerButton Error")
        }
    }
    
    @IBAction func coopModeButtonTapped(_ sender: UIButton) {
        coopModeButtons.forEach { button in
            button.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            coopAnswer = .True
        case 2:
            coopAnswer = .False
        default:
            print("Tag playerButton Error")
        }
    }
    
    // MARK: Class Methods
    
    private func gamesCall(platform: String, players: String, coop: String) {
        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; where platforms = (\(platform)) & multiplayer_modes.offlinemax \(players) & multiplayer_modes.offlinecoop = \(coop) & total_rating > 70; limit 100;"
        igdbService.getResult(httpBody: httpBodyString) { (result: Result<[Game], Error>) in
            
            switch result {
            case .success(let data):
                self.gameList = data
                if data.count >= 1{
                    self.performSegue(withIdentifier: "segueToCollectionViewController", sender: self)
                }else{
                    self.presentAlert(message: "We have no result for your search")
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

extension MultiplayerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/4), animated: false)
    }
}
