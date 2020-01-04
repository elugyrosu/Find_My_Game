//
//  CollectionViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 10/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage


class CollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let spacing:CGFloat = 15
    var gameList = [Game]()
    var game: Game?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()}
        self.game = gameList[indexPath.row]
        cell.game = game
        
        guard let imageId = game?.cover?.image_id else{return cell}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        cell.coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "no image.png"))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game = gameList[indexPath.row]
        performSegue(withIdentifier: "segueToDetail", sender: indexPath)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail"{
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.game = game
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
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

