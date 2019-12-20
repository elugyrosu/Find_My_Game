//
//  CollectionViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 10/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit
import SDWebImage


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var gameList = [Game]()
    var game: Game?
    
    private let spacing:CGFloat = 15

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        
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
    

//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return gameList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()}
        self.game = gameList[indexPath.row]
        cell.game = game
        
        guard let imageId = game?.cover?.image_id else{return cell}
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        cell.coverImageView.sd_setImage(with: URL(string: imageStringUrl), placeholderImage: UIImage(named: "co1rxc.png"))
            
    return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game = gameList[indexPath.row]
        performSegue(withIdentifier: "segueToDetail", sender: indexPath)
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail"{
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.game = game
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//      return CGSize(width: itemSize, height: itemSize)
//    }


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
