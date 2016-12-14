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
    @IBOutlet weak var selectView: UIView!
    
    func configureCell(merchant: Merchant) {
        
        self.merchNameLabel.text = merchant.name
        self.merchRatingLabel.text = merchant.rating
        self.merchDistanceLabel.text = "x m"
        self.selectView.backgroundColor = UIColor.white
        if let image = merchant.image {
            self.merchImage.image = UIImage(named: image)
        }
        
    }
}
