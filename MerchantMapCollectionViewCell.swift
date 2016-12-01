//
//  MerchantMapCollectionViewCell.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 30/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class MerchantMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchNameLabel: UILabel!
    @IBOutlet weak var merchDistanceLabel: UILabel!
    @IBOutlet weak var merchRatingLabel: UILabel!
    
    func configureCell(merchant: Merchant) {
        
        self.merchNameLabel.text = merchant.name
        self.merchRatingLabel.text = merchant.rating
        self.merchDistanceLabel.text = "x m"
        self.merchImage.image = UIImage(named: merchant.image)
        
    }
}
