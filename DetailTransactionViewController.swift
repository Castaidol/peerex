//
//  DetailTransactionViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 1/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class DetailTransactionViewController: UIViewController {

    @IBOutlet weak var merchNameLabel: UILabel!
    @IBOutlet weak var cashRequestedLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var merchPhoneLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var merchLocationLabel: UILabel!
    
    var transData: Merchant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        merchNameLabel.text = transData.name
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

   

}
