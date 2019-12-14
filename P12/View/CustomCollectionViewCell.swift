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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var game: Game? {
        didSet {
            guard let game = game else{return}
            nameLabel.text = game.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    


}
