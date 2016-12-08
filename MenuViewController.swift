//
//  MenuViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 23/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        
        ref.child("Traveler").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstName"] as? String ?? ""
            self.nameLabel.text = firstName
        })
        
        profilePic.layer.cornerRadius = 45
        profilePic.layer.borderWidth = 5
        profilePic.layer.borderColor = UIColor.init(red: 88, green: 193, blue: 153, alpha: 1).cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        try! FIRAuth.auth()!.signOut()
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
        
        //self.navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
