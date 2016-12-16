//
//  DetailTransactionViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 1/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import Alamofire

/*protocol PassDataDelegate{
    
    //func passTheArray(dataArray: Merchant)
    func passTheMoneyAmount(dataMoney: Double)
}*/

class DetailTransactionViewController: UIViewController {

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
    
    //var delegate: PassDataDelegate?
    //var dataArray: Merchant?
    //var dataMoney: Double?
    
    var transData: Merchant!
    var amountSGD: Double!
    var fees: Double!
    var total: Double!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        merchRating.text = transData.rating
        merchLocationLabel.text = transData.address

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
   /* override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed {
            self.delegate?.passTheMoneyAmount(dataMoney: amountSGD)
        }
    }*/
    

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
