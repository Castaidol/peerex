//
//  EditAccountViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 25/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit



class EditAccountViewController: UIViewController {
    
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func saveProfileBtn(_ sender: Any) {
        
        
        if var firstNameValue = firstNameText.text{
            
            
            
        }
        
        
    }

   
}
