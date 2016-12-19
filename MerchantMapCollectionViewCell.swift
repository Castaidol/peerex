//
//  MerchantMapCollectionViewCell.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 30/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreLocation

class MerchantMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchNameLabel: UILabel!
    @IBOutlet weak var merchDistanceLabel: UILabel!
    @IBOutlet weak var merchRatingLabel: UILabel!
    @IBOutlet weak var selectView: UIView!
    
    var manager: CLLocationManager!
    
    func configureCell(merchant: Merchant) {
        
        self.merchNameLabel.text = merchant.name
        self.merchRatingLabel.text = "\(merchant.rating)"
        self.selectView.backgroundColor = UIColor.white
        if merchant.image != nil {
            self.merchImage.af_setImage(withURL: merchant.image!)
        } else {
            self.merchImage.image = nil
        }
        
    }
}
