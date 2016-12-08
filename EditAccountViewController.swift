//
//  EditAccountViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 25/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class EditAccountViewController: UIViewController {
    
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    var refHandle: UInt!
    let user = FIRAuth.auth()?.currentUser
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        styleView()
        
        ref = FIRDatabase.database().reference()
        refHandle = ref.observe(FIRDataEventType.value, with: { (FIRDataSnapshot) in
            let dataDict = FIRDataSnapshot.value as! [String : AnyObject]
            
            print (dataDict)
        })
        
        ref.child("Traveler").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstName"] as? String ?? ""
            let lastName = value?["lastName"] as? String ?? ""
            let phoneNumber = value?["phoneNumber"] as? String ?? ""
            self.firstNameText.text = firstName
            self.lastNameText.text = lastName
            self.phoneNumber.text = phoneNumber
                        
        })
        
        let email = user?.email
        self.emailText.text = email
        
        firstNameText.borderStyle = UITextBorderStyle.none
        lastNameText.borderStyle = UITextBorderStyle.none
        phoneNumber.borderStyle = UITextBorderStyle.none
        emailText.borderStyle = UITextBorderStyle.none

        
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func styleView(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        profilePicture.layer.cornerRadius = 64
        profilePicture.layer.borderWidth = 5
        profilePicture.layer.borderColor = UIColor.init(red: 0, green: 150, blue: 109, alpha: 1).cgColor
        
    }
    
    @IBAction func saveProfileBtn(_ sender: Any) {
        
        let travelerFirstName: String = self.firstNameText.text!
        let travelerLastName: String = self.lastNameText.text!
        let travelerPhoneNumber: String = self.phoneNumber.text!
        
        self.ref.child("Traveler").child(userId).setValue(["firstName" : travelerFirstName, "lastName" : travelerLastName, "phoneNumber" : travelerPhoneNumber])
        
    }
    
    @IBAction func goBack(){
        
            }
        
        

   
}
