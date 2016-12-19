//
//  MyTransactionsDetailsViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 16/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import AlamofireImage

class MyTransactionsDetailsViewController: UIViewController {
    
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchName: UILabel!
    @IBOutlet weak var merchAddress: UILabel!
    @IBOutlet weak var transID: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var requestedSGD: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    var transactionID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        ref.child("Traveler").child(userId).child("Transactions").child(transactionID as String).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            
            let value = snapshot.value as? NSDictionary
            
            let requestedCash = value?["requestedMoney"] as? Double
            let transactionID = value?["transactionID"] as? String ?? ""
            //let status = value?["status"] as? String ?? ""
            let date = value?["date"] as? String ?? ""
            let time = value?["time"] as? String ?? ""
            let address = value?["merchantAddress"] as? String ?? ""
            let name = value?["merchantName"] as? String ?? ""
            let feeMOney = value?["fees"] as? Double
            let totalMoney = value?["totalCharged"] as? Double
            let merchImage = value?["merchImage"] as? String ?? ""
            
            
            
            self.requestedSGD.text = "$\(formatter.string(from: requestedCash! as NSNumber)! )"
            self.merchName.text = name
            self.merchAddress.text = address
            self.transactionDate.text = "\(date), \(time)"
            self.fee.text = "$\(formatter.string(from: feeMOney! as NSNumber)! )"
            self.total.text = "$\(formatter.string(from: totalMoney! as NSNumber)! )"
            self.transID.text = "\(transactionID)"
            if let url = URL(string: merchImage) {
                self.merchImage.af_setImage(withURL: url)
            }
            
            
            
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
