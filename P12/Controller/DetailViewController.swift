//
//  DetailViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 09/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    
    var game: Game?
    var screenshot: Cover?
    var screenshots = [Cover]()
    

    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet var cornerViews: [UIView]!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBAction func handleFavoriteBarButtonItem(_ sender: UIBarButtonItem) {
        guard let id = game?.id else {return}
        
        if FavoriteGame.checkIfAlreadyExist(gameId: String(id)) == true{
            FavoriteGame.deleteGame(gameId: String(id))
        }else{
            guard let favoriteGame = game else{return}
            FavoriteGame.addGame(game: favoriteGame)
        }
        checkIfFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: ScreenshotCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        cornerViews.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }
    
    private func updateViews(){
        guard let game = game else{return}
        titleLabel.text = game.name
        summaryLabel.text = game.summary
        if let timestamp = game.first_release_date {
            releaseDateLabel.text = createDateTime(timestamp: timestamp)
        }
        getCoverImage()
        guard let score = game.total_rating else {return}
        scoreLabel.text = String(Int(score)) + "/100"
    }
    
    func getCoverImage() {
        guard let imageId = game?.cover?.image_id else {return}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
    }
    
    func createDateTime(timestamp: Int) -> String {
        var strDate = "undefined"
            
        let unixTime = Double(timestamp)
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd MMM yyyy"
            strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    private func checkIfFavorite(){
        guard let game = game else {return}
        if FavoriteGame.checkIfAlreadyExist(gameId: String(game.id)) == true{
            favoriteBarButtonItem.image = #imageLiteral(resourceName: "Full star")
        }else{
            favoriteBarButtonItem.image = #imageLiteral(resourceName: "Empty Star")
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
        screenshot = screenshots[indexPath.row]
        guard let imageId = screenshot?.image_id else{return cell}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_screenshot_med/\(imageId).jpg"
        cell.screenshotImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 120)
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let game = game else {return 0}

        return game.platforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
            cell = tableView.dequeueReusableCell(withIdentifier: "platformCell", for: indexPath)
            guard let platform = game?.platforms[indexPath.row].name else{
                return cell
            }
            cell.textLabel?.text = platform

        return cell
    }
    
    
}
