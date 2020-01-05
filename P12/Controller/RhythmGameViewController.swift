//
//  VRViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 19/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class RhythmGameViewController: UIViewController {
    
    // MARK: Properties

    private let igdbService = IGDBService()
    private var gameList = [Game]()
    private var platformAnswer = Platform.PS4

    // MARK: Outlets

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var platformButtons: [UIButton]!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
    }
    
    // MARK: Action Button Outlets

    @IBAction func resultButtonTapped(_ sender: Any) {
        gamesCall(platform: platformAnswer.rawValue)
    }
    
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
            platformAnswer = .iOS
        default:
            print("Tag platform Error")
        }
    }

    // MARK: Class Methods
    
    private func toggleActivityIndicator(shown: Bool){
        activityIndicatorView.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    private func gamesCall(platform: String) {
        toggleActivityIndicator(shown: true)
        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; where platforms = (\(platform)) & genres = (7) & total_rating > 70; limit 100;"
        igdbService.getResult(httpBody: httpBodyString) { result in
            self.toggleActivityIndicator(shown: false)
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

extension RhythmGameViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/2), animated: false)
    }
}
