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

class MyTransactionsDetailsViewController: UIViewController {
    
    @IBOutlet weak var ve: UILabel!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    var transactionID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        ref.child("Traveler").child(userId).child("Transactions").child(transactionID as String).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            print(value as Any)
            
            let requestedCash = value?["requestedMoney"] as? Double
            
            print(requestedCash!)
            
            
            
            
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
