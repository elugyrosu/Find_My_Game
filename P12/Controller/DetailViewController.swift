//
//  DetailViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 09/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var game: Game?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViews()
        
    }
    
    private func updateViews(){
        guard let game = game else{return}
        titleLabel.text = game.name
        summaryLabel.text = game.summary

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
