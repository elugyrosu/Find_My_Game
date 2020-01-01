//
//  FindViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 09/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    private let igdbService = IGDBService()
    private var gameList = [Game]()
    
    @IBOutlet var viewsToBorder: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsToBorder.forEach {view in
            view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            view.layer.borderWidth = 0.2
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func vrButtonTapped(_ sender: UIButton) {
        gamesVRCall()
    }
    private func gamesVRCall() {
    //        let httpBodyString = "fields *, cover.image_id, screenshots.image_id, age_ratings.* , genres.* ; where platforms = (\(platforms)) & total_rating > 70 & themes = (\(themes)) & genres = (\(genres)) & age_ratings.rating = (\(ageRating)); limit 100;"
            let httpBodyString = "fields *, cover.image_id, screenshots.image_id, genres.name, themes.name, platforms.name; sort total_rating desc; where platforms = (162,163,165) & total_rating > 70; limit 100;"
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
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueToCollectionViewController" {
                guard let resultVC = segue.destination as? CollectionViewController else{return}
                resultVC.gameList = gameList
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
