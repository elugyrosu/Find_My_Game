//
//  FavoriteCollectionViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 22/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage



class FavoriteCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var gameList = FavoriteGame.fetchAll()
    private var favoriteGame: FavoriteGame?
    
    private let spacing:CGFloat = 15
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameList = FavoriteGame.fetchAll()
        collectionView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nib = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        checkFavorite()
        // Do any additional setup after loading the view.
    }
    func checkFavorite() {
        if gameList.count > 0 {
            favoriteGame = gameList[0]
            guard let name = favoriteGame?.name else {return}
            print(name)
        }
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return gameList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()}
        favoriteGame = gameList[indexPath.row]
        cell.favoriteGame = favoriteGame
        
        guard let coverId = favoriteGame?.cover else{return cell}
//        cell.coverImageView.image = UIImage(data: coverData)
        // Configure the cell
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverId).jpg"
        cell.coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
    
        return cell
    }
   
    
    

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoriteGame = gameList[indexPath.row]
        performSegue(withIdentifier: "segueToFavoriteDetailViewController", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteDetailViewController"{
            guard let detailVC = segue.destination as? FavoriteDetailViewController else {return}
            detailVC.favoriteGame = favoriteGame
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
