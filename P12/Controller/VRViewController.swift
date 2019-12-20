//
//  VRViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 19/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class VRViewController: UIViewController {
    private let igdbService = IGDBService()
    private var gameList = [Game]()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func resultButtonTapped(_ sender: Any) {
        gamesCall()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func gamesCall() {
//        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, age_ratings.* , genres.* ; where platforms = (\(platforms)) & total_rating > 70 & themes = (\(themes)) & genres = (\(genres)) & age_ratings.rating = (\(ageRating)); limit 100;"
        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; where platforms = (162,163,165) & total_rating > 70; limit 100;"
        igdbService.getResult(httpBody: httpBodyString) { (result: Result<[Game], Error>) in
            
            switch result {
            case .success(let data):
                self.gameList = data
                if data.count >= 1{
                    self.performSegue(withIdentifier: "segueToCollectionViewController", sender: self)
                }else{
                    self.presentAlert(message: "We have no recipe for your search, check your ingredients")
                }
            case .failure(let error):
                print(error.localizedDescription)
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

extension VRViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/4), animated: false)
    }
}
