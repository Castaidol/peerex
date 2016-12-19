//
//  CurrentTransactionDetailsViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 16/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import AlamofireImage

class CurrentTransactionDetailsViewController: UIViewController {

    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchName: UILabel!
    @IBOutlet weak var merchAddress: UILabel!
    @IBOutlet weak var openingHours: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    @IBOutlet weak var requestedCash: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var call: UIButton!
    
    
    var transRefID:String!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancel.layer.cornerRadius = 5
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.black.cgColor
        call.layer.cornerRadius = 5
        
        ref = FIRDatabase.database().reference()
        ref.child("Traveler").child(userId).child("Transactions").child(transRefID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            let merchName = value?["merchantName"] as? String ?? ""
            let merchAddress = value?["merchantAddress"] as? String ?? ""
            let requestedCash = value?["requestedMoney"] as? Double
            let fee = value?["fees"] as? Double
            let total = value?["totalCharged"] as? Double
            let merchImage = value?["merchImage"] as? String ?? ""
            let rating = value?["rating"] as? String ?? ""
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            self.rating.text = "\(rating)"
            self.merchName.text = merchName
            self.merchAddress.text = merchAddress
            self.transactionID.text = self.transRefID
            self.requestedCash.text = "$\(formatter.string(from: requestedCash! as NSNumber)!)"
            self.fee.text = "$\(formatter.string(from: fee! as NSNumber)!)"
            self.total.text = "$\(formatter.string(from: total! as NSNumber)!)"
            if let url = URL(string: merchImage) {
                self.merchImage.af_setImage(withURL: url)
            }
            
            
        })
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
