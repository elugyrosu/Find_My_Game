//
//  CustomCollectionViewCell.swift
//  P12
//
//  Created by Jordan MOREAU on 10/12/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!

    var game: Game? {
        didSet {
            guard let rating = game?.total_rating else {return}
            ratingLabel.text = String(Int(rating))
        }
    }
    var favoriteGame: FavoriteGame?{
        didSet {
            guard let rating = favoriteGame?.totalRating else {return}
            ratingLabel.text = rating
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coverImageView.layer.cornerRadius = 6
        coverImageView.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = ratingLabel.frame.size.height/2
        ratingLabel.layer.masksToBounds = true


    }
    


}
