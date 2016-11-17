//
//  SignInViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 17/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailSignInText: UITextField!
    @IBOutlet weak var passwordSignInText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valodateEmail(){
        
    }
    
    func validatePassword(){
        
        
    }
    
    @IBAction func singInAction(_ sender: Any) {
        
        FIRAuth.auth()?.createUser(withEmail: emailSignInText.text!, password: passwordSignInText.text!) { (user, error) in
           
            
            
        }
        
        
        
    }

    
    
}
