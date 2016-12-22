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
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    var manager: CLLocationManager!
    var star: UIImage = UIImage(named: "rate-big-selected.png")!
    var noStar: UIImage = UIImage(named: "rate-big-nonselected.png")!
    
    func configureCell(merchant: Merchant) {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        self.merchNameLabel.text = merchant.name
        self.merchRatingLabel.text = "\(formatter.string(from: merchant.rating as NSNumber)!)"
        self.selectView.backgroundColor = UIColor.white
        if merchant.image != nil {
            self.merchImage.af_setImage(withURL: merchant.image!)
        } else {
            self.merchImage.image = nil
        }
        
        if merchant.rating < 2{
            
            star1.image = star
            star2.image = noStar
            star3.image = noStar
            star4.image = noStar
            star5.image = noStar
            
            
        }else if merchant.rating >= 2 && merchant.rating < 3 {
            
            star1.image = star
            star2.image = star
            star3.image = noStar
            star4.image = noStar
            star5.image = noStar
            
        }else if merchant.rating >= 3 && merchant.rating < 4 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = noStar
            star5.image = noStar
            
        }else if merchant.rating >= 4 && merchant.rating < 5 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = star
            star5.image = noStar
            
        }else if merchant.rating == 5 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = star
            star5.image = star
        }
        
    }
}
