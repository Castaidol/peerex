//
//  ViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 16/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var emailLogInText: UITextField!
    @IBOutlet weak var passwordLogInText: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if FIRAuth.auth()?.currentUser != nil{
            
            self.performSegue(withIdentifier: "GoToHomePage", sender: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInAction(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailLogInText.text!, password: passwordLogInText.text!) { (user, error) in
            
            if error == nil{
                
               self.performSegue(withIdentifier: "GoToHomePage", sender: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Invalid Login", message: "Email/Password incorrect", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
            
        }
        
        
        
        
    }

    func styleView(){
        
        passwordLogInText.borderStyle = UITextBorderStyle.none
        emailLogInText.borderStyle = UITextBorderStyle.none
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.cornerRadius = 5
        logInButton.layer.cornerRadius = 5

        
    }
    
    
    

}

