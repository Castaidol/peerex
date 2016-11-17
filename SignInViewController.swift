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
    
    var validEmail = false
    var validPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func isValidPassword(testStr:String) -> Bool{
        
        if testStr.characters.count >= 8 && testStr.characters.count <= 16{
        
            let capNumLowRegEx = "[A-Z0-9a-z]+"
            var passwordTest = NSPredicate(format: "SELF MATCHES %@", capNumLowRegEx)
            let capNumLowresult = passwordTest.evaluate(with: testStr)
        
            let NumRegEx = ".*[0-9]+.*"
            passwordTest = NSPredicate(format: "SELF MATCHES %@", NumRegEx)
            let numResult = passwordTest.evaluate(with: testStr)
        
            let capRegEx = ".*[A-Z]+.*"
            passwordTest = NSPredicate(format: "SELF MATCHES %@", capRegEx)
            let capresult = passwordTest.evaluate(with: testStr)
        
            return capNumLowresult && numResult && capresult
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
            
        }
        
        if isValidPassword(testStr: passwordSignInText.text!) == true{
            
            validPassword = true
            print("password good")
            
        }else{
            
            let alert = UIAlertController(title: "Invalid Password", message: "Password must be between 8 and 16 characters and contain at least a number and a capital letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        
        if validEmail == true && validPassword == true {
            
//            FIRAuth.auth()?.createUser(withEmail: emailSignInText.text!, password: passwordSignInText.text!) { (user, error) in
            
            let alert = UIAlertController(title: "Very good", message: "You have successfully sign in", preferredStyle: UIAlertControllerStyle.alert)
            let goBackAction = UIAlertAction(title: "Go to Login", style: .default) { (action) in
                self.performSegue(withIdentifier: "GoToLogin", sender: nil)
                
            }
            alert.addAction(goBackAction)
            self.present(alert, animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }

    
    
}
