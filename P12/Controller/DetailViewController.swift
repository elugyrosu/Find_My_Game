//
//  DetailViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 09/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    var game: Game?
    var screenshot: Cover?
    var screenshots = [Cover]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: ScreenshotCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
        updateViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)


        
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
        coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
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
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let screenshots = game?.screenshots else {return 0}
        self.screenshots = screenshots
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.identifier, for: indexPath) as? ScreenshotCollectionViewCell else {
            return ScreenshotCollectionViewCell()
            
        }
        self.screenshot = screenshots[indexPath.row]

        
        guard let imageId = screenshot?.image_id else{return cell}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        cell.screenshotImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
        
        return cell
    }
    
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 100)
    }
}

