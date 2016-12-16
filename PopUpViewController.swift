//
//  PopUpViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 12/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
import FirebaseDatabase

class PopUpViewController: UIViewController/*, PassDataDelegate*/{
    
    @IBOutlet weak var amountMoney: UILabel!
    @IBOutlet weak var merchNAme: UILabel!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    var refHandle: UInt!
    let user = FIRAuth.auth()?.currentUser
    
    var transData: Merchant!
    var amountSGD: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

               self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        showAnimate()
        
        merchNAme.text = transData.name
        amountMoney.text = String(amountSGD)
        
        /*let pvc = storyboard?.instantiateViewController(withIdentifier: "DetailTransactionViewController") as! DetailTransactionViewController
        pvc.dataMoney = 0
        pvc.delegate = self
        self.present(pvc, animated: true, completion: nil)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    /*
    func passTheArray(data: Merchant){
    
        merchNAme.text = data.name
    
    }
    
    func passTheMoneyAmount(dataMoney: Double){
        
        self.amountMoney.text = "\(dataMoney)"
        
        
    }*/

    
    @IBAction func requestMoneyBtn(_ sender: Any) {
        
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
            

            let email = self.user?.email
        
            var parameters: [String: AnyObject] = [:]
            parameters["firstname"] = "\(firstName)" as AnyObject?
            parameters["lastname"] = "\(lastName)" as AnyObject?
            parameters["email"] = "\(email)" as AnyObject
            parameters["number"] = Int(phoneNumber) as AnyObject
            parameters["merchant_id"] = 1 as AnyObject
        
            Alamofire.request("https://boiling-castle-76624.herokuapp.com/transactionapi", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
                if response.result.value != nil {
                
                    let json = response.result.value as? [String: Any]
                
                    let transactionRef = json?["transref"] as! String
                    let status = json?["status"] as! String
                
                    print(transactionRef)
                    print(status)
                    
                    let date = NSDate()
                    let calendar = NSCalendar.current
                    let day = calendar.component(.day , from: date as Date)
                    let month = calendar.component(.month , from: date as Date)
                    let year = calendar.component(.year , from: date as Date)
                    let hour = calendar.component(.hour, from: date as Date)
                    let minutes = calendar.component(.minute, from: date as Date)
                    let time = "\(hour):\(minutes)"
                    let dmy = "\(day)-\(month)-\(year)"
                    
                    print(dmy)
                    print(time)
                    
                    self.ref.child("Traveler").child(self.userId).child("Transactions").child(transactionRef).setValue(["transactionID" : transactionRef, "date" : dmy, "time" : time, "status" : status])
                
                }
            }
         })
    }

    
    @IBAction func closeBtn(_ sender: Any) {
        
        removeAnimate()
        
    }
    
    func showAnimate(){
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)

        })
        
    }
    
    func removeAnimate(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            self.view.alpha = 0.0
        }, completion:{(finished: Bool) in
            if (finished){
                
                self.removeFromParentViewController()
            }
        })
        
        self.navigationController?.navigationBar.isHidden = false
    }
}
