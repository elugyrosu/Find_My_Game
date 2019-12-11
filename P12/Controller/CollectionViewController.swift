//
//  CollectionViewController.swift
//  P12
//
//  Created by Jordan MOREAU on 10/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CustomCollectionViewCell"

class CollectionViewController: UICollectionViewController {
    private let imageCache = NSCache<NSString, UIImage>()
    var gameList = [Game]()
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
//        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
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
        return self.gameList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()}
        self.game = gameList[indexPath.row]
        cell.game = game
        
        
        guard let imageId = game?.cover?.image_id else {
            cell.coverImageView.image = UIImage(named: "co1rxc")
            return cell
        }
        let imageStringUrl = "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).jpg"
        if let cachedImage = imageCache.object(forKey:NSString(string:imageStringUrl)) {
            cell.coverImageView.image = cachedImage
        }else{
            guard let imageData = imageStringUrl.data else { return cell}
            guard let image = UIImage(data: imageData) else {
                return cell
            }
            self.imageCache.setObject(image, forKey: NSString(string: imageStringUrl))
            cell.coverImageView.image = image
        }
        cell.coverImageView.contentMode = .scaleAspectFill
        return cell
        
//        cell.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//        cell.layer.borderWidth = 2
        // Configure the cell
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
