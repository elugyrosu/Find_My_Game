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
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViews()
        
    }
    
    private func updateViews(){
        guard let game = game else{return}
        titleLabel.text = game.name
        summaryLabel.text = game.summary
        if let timestamp = game.first_release_date {
            releaseDateLabel.text = createDateTime(timestamp: timestamp)
        }
        getImage()
        guard let score = game.total_rating else {return}
        scoreLabel.text = String(score)
    }
    
    func getImage() {
        guard let imageId = game?.cover?.image_id else {return}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        guard let imageData = imageStringUrl.data else { return }
        coverImageView.image = UIImage(data: imageData)
    }
    
    func createDateTime(timestamp: Int) -> String {
        var strDate = "undefined"
            
        let unixTime = Double(timestamp)
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd.MM.yyyy" 
            strDate = dateFormatter.string(from: date)
        return strDate
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
