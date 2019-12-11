//
//  QuizzViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 03/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {
//    let progress = Progress(totalUnitCount: 5)
    @IBOutlet weak var imageView: UIImageView!
    

    private let igdbService = IGDBService()
    private var gameList = [Game]()
    private var gameListCount = 0
 
    @IBOutlet weak var questionOneButtons: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var gestresultsButton: UIButton!
    
    @IBAction func getResults(_ sender: Any) {
        gamesCall()
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func gamesCall(){
        igdbService.getResult { success, igdbResults in
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
            resultVC.gameList = self.gameList
        }
    }
    
}
extension QuizzViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = (scrollView.contentOffset.x/pageWidth)
        progressView.setProgress(Float(pageFraction/6), animated: false)

//        pageControl.currentPage = Int((round(pageFraction)))
    }
}
