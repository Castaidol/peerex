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
    @IBOutlet weak var reTypePassword: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    var validEmail = false
    var validPassword = false
    var samePassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword(testPass:String) -> Bool{
        
        if testPass.characters.count >= 8 && testPass.characters.count <= 16{
        
            let capNumLowRegEx = "[A-Z0-9a-z]+"
            var passwordTest = NSPredicate(format: "SELF MATCHES %@", capNumLowRegEx)
            let capNumLowresult = passwordTest.evaluate(with: testPass)
        
            let NumRegEx = ".*[0-9]+.*"
            passwordTest = NSPredicate(format: "SELF MATCHES %@", NumRegEx)
            let numResult = passwordTest.evaluate(with: testPass)
        
            let capRegEx = ".*[A-Z]+.*"
            passwordTest = NSPredicate(format: "SELF MATCHES %@", capRegEx)
            let capresult = passwordTest.evaluate(with: testPass)
        
            return capNumLowresult && numResult && capresult
        }else{
            
            return false
        }
    }
    
    func confirmPassword(pass: String, reType: String ) -> Bool{
        
        if pass == reType{
            
            return true
            
            
        }else{
            
            return false
        }
        
    }
    
    @IBAction func singInAction(_ sender: Any) {
        
        if isValidEmail(testStr: emailSignInText.text!) == true{
            
            validEmail = true
            print("email good")
            
        }else{
            
            let alert = UIAlertController(title: "Invalid Email", message: "Enter a valid email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        if isValidPassword(testPass: passwordSignInText.text!) == true{
            
            validPassword = true
            print("password good")
            
        }else{
            
            let alert = UIAlertController(title: "Invalid Password", message: "Password must be between 8 and 16 characters and contain at least a number and a capital letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return

        }
        
        if confirmPassword(pass: passwordSignInText.text!, reType: reTypePassword.text!){
            
            samePassword = true
            print("same password")
        }else{
            
            let alert = UIAlertController(title: "Invalid Password", message: "Password and Confirm Password are not the same", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
    
        
        if validEmail == true && validPassword == true && samePassword == true  {
            
            FIRAuth.auth()?.createUser(withEmail: emailSignInText.text!, password: passwordSignInText.text!) { (user, error) in
                
                if error == nil{
                    
                    let alert = UIAlertController(title: "Very good", message: "You have successfully sign in", preferredStyle: UIAlertControllerStyle.alert)
                    let goBackAction = UIAlertAction(title: "Go to Login", style: .default) { (action) in
                        self.performSegue(withIdentifier: "GoToLogin", sender: nil)
                        
                    }
                    alert.addAction(goBackAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }else if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!){
                    
                    if errCode == .errorCodeEmailAlreadyInUse {
                        
                        let alert = UIAlertController(title: "Invalid Email", message: "The email address is already in use by another account", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                    }
                }
            }
        }
    }
    
    func styleView(){
        
        logInButton.layer.borderColor = UIColor.black.cgColor
        logInButton.layer.borderWidth = 1
        logInButton.layer.cornerRadius = 5
        singUpButton.layer.cornerRadius = 5
        emailSignInText.borderStyle = UITextBorderStyle.none
        passwordSignInText.borderStyle = UITextBorderStyle.none
        reTypePassword.borderStyle = UITextBorderStyle.none
    }
}


