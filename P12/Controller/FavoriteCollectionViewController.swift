//
//  FavoriteCollectionViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 22/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage



class FavoriteCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    
    private var gameList = FavoriteGame.fetchAll()
    private var favoriteGame: FavoriteGame?
    private let spacing:CGFloat = 15
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameList = FavoriteGame.fetchAll()
        let nib = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        collectionView.reloadData()
        checkFavorite()
    }
    
    // MARK: Class Methods
    
    private func checkFavorite() {
        if gameList.count > 0 {
            favoriteGame = gameList[0]
            guard let name = favoriteGame?.name else {return}
            print(name)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()}
        favoriteGame = gameList[indexPath.row]
        cell.favoriteGame = favoriteGame
        guard let coverId = favoriteGame?.cover else{return cell}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverId).jpg"
        cell.coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoriteGame = gameList[indexPath.row]
        performSegue(withIdentifier: "segueToFavoriteDetailViewController", sender: indexPath)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteDetailViewController"{
            guard let detailVC = segue.destination as? FavoriteDetailViewController else {return}
            detailVC.favoriteGame = favoriteGame
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 15
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width*4/3)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
