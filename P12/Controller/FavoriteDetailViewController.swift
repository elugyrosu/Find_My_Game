//
//  FavoriteDetailViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 22/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteDetailViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    
    
    
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var cornerViews: [UIView]!
    
    
    private var favoriteList = FavoriteGame.fetchAll()
    var favoriteGame: FavoriteGame?
    var screenshots = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBAction func handleFavoriteBarButtonItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Caution", message: "Do you really want to remove this game from your favorite list ?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            guard let game = self.favoriteGame else{return}
            guard let id = game.id else {return}
            FavoriteGame.deleteGame(gameId: id)
            self.navigationController?.popViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        let nib = UINib(nibName: ScreenshotCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cornerViews.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }
    
    private func checkIfFavorite(){
        guard let game = favoriteGame else {return}
        guard game.id != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
    }
    private func updateViews(){
        getCoverImage()
        guard let game = favoriteGame else{return}
        titleLabel.text = game.name
        summaryLabel.text = game.summary
        releaseDateLabel.text = game.releaseDate
        guard let rating = game.totalRating else {return}
        scoreLabel.text = rating + "/100"
    }
    
    func getCoverImage() {
        guard let imageId = favoriteGame?.cover else {return}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        imageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
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

extension FavoriteDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let screenshots = favoriteGame?.screenshots else {return 0}
        self.screenshots = screenshots as [String]
        return screenshots.count

    }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.identifier, for: indexPath) as? ScreenshotCollectionViewCell else {
                return ScreenshotCollectionViewCell()
            }
            let imageId = screenshots[indexPath.row]
            let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_screenshot_med/\(imageId).jpg"
            cell.screenshotImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))

            return cell
        }
}
extension FavoriteDetailViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 120)
    }
}

extension FavoriteDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let platforms = favoriteGame?.platforms else {return 0}

        return platforms.count
//        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

            cell = tableView.dequeueReusableCell(withIdentifier: "platformCell", for: indexPath)
            guard let platforms = favoriteGame?.platforms else{
                return cell
            }
        cell.textLabel?.text = platforms[indexPath.row] as String

        return cell
    }


}
