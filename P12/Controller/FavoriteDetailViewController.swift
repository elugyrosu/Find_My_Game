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
    
    // MARK: Properties
    
    private var favoriteList = FavoriteGame.fetchAll()
    var favoriteGame: FavoriteGame?
    var screenshots = [String]()
    
    // MARK: Outlets
    
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var cornerViews: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        let nib = UINib(nibName: ScreenshotCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }
    
    // MARK: View Life Cycle
    
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
    
    // MARK: Class Methods
    
    private func checkIfFavorite(){
        guard let game = favoriteGame else {return}
        guard game.id != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
    }
    
    private func updateViews(){
        cornerViews.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
        getCoverImage()
        guard let game = favoriteGame else{return}
        titleLabel.text = game.name
        summaryLabel.text = game.summary
        releaseDateLabel.text = game.releaseDate
        guard let rating = game.totalRating else {return}
        scoreLabel.text = rating + "/100"
    }
    
    private func getCoverImage() {
        guard let imageId = favoriteGame?.cover else {return}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        imageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "no image.png"))
    }
}

// MARK: UICollectionViewDataSource

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
        cell.screenshotImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "no image.png"))
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FavoriteDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 140
        )
    }
}

// MARK: UITableViewDataSource

extension FavoriteDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let platforms = favoriteGame?.platforms else {return 0}
        return platforms.count
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
