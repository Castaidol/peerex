//
//  DetailTransactionViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 1/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class DetailTransactionViewController: UIViewController{

    @IBOutlet weak var merchNameLabel: UILabel!
    @IBOutlet weak var cashRequestedLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var merchLocationLabel: UILabel!
    @IBOutlet weak var merchRating: UILabel!
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var requestCashBtn: UIButton!
    @IBOutlet weak var callMerchantBtn: UIButton!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var transData: Merchant!
    var amountSGD: Double!
    var fees: Double!
    var total: Double!
    
    var star: UIImage = UIImage(named: "rate-big-selected.png")!
    var noStar: UIImage = UIImage(named: "rate-big-nonselected.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if transData.image != nil{
            self.merchImage.af_setImage(withURL: self.transData.image!)
        }
        
        requestCashBtn.layer.cornerRadius = 5
        callMerchantBtn.layer.cornerRadius = 5
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        fees = (amountSGD/100)*9
        total = fees + amountSGD
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        cashRequestedLabel.text = "$\(formatter.string(from: amountSGD as NSNumber)!)"
        feeLabel.text = "$\(formatter.string(from: fees as NSNumber)!)"
        totalCostLabel.text = "$\(formatter.string(from: total as NSNumber)!)"
        
        merchNameLabel.text = transData.name
        merchRating.text = "\(transData.rating)"
        merchLocationLabel.text = transData.address
        
        
        if transData.rating < 2{
            
            star1.image = star
            star2.image = noStar
            star3.image = noStar
            star4.image = noStar
            star5.image = noStar
            
            
        }else if transData.rating >= 2 && transData.rating < 3 {
            
            star1.image = star
            star2.image = star
            star3.image = noStar
            star4.image = noStar
            star5.image = noStar
            
        }else if transData.rating >= 3 && transData.rating < 4 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = noStar
            star5.image = noStar
            
        }else if transData.rating >= 4 && transData.rating < 5 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = star
            star5.image = noStar
            
        }else if transData.rating == 5 {
            
            star1.image = star
            star2.image = star
            star3.image = star
            star4.image = star
            star5.image = star
        }


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    

    @IBAction func requestCashBtn(_ sender: Any) {
        
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        
        popOverVC.transData = self.transData
        popOverVC.amountSGD = self.amountSGD
        popOverVC.fees = self.fees
        popOverVC.total = self.total
        
        
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
            
}
