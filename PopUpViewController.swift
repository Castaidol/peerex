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


class PopUpViewController: UIViewController{
    
    @IBOutlet weak var amountMoney: UILabel!
    @IBOutlet weak var merchNAme: UILabel!
    @IBOutlet weak var requestMoney: UIButton!
    @IBOutlet weak var cancelRequest: UIButton!
    @IBOutlet weak var popView: UIView!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    var refHandle: UInt!
    let user = FIRAuth.auth()?.currentUser
    
    var transData: Merchant!
    var amountSGD: Double!
    var fees: Double!
    var total: Double!
    var transRefID:String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popView.layer.cornerRadius = 8

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        showAnimate()
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        merchNAme.text = "from \(transData.name)"
        amountMoney.text = "$\(formatter.string(from: amountSGD as NSNumber)!)"
        
        requestMoney.layer.cornerRadius = 5
        cancelRequest.layer.cornerRadius = 5
        cancelRequest.layer.borderColor = UIColor.black.cgColor
        cancelRequest.layer.borderWidth = 1
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    
    @IBAction func requestMoneyBtn(_ sender: Any) {
        
        
        self.ref = FIRDatabase.database().reference()
        self.ref.child("Traveler").child(self.userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            parameters["merchant_id"] = "\(self.transData.merchID)" as AnyObject
            parameters["amount"] = self.amountSGD as AnyObject
                    
            Alamofire.request("https://boiling-castle-76624.herokuapp.com/transactionapi", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
                if response.result.value != nil {
                
                    let json = response.result.value as? [String: Any]
                
                    let transactionRef = json?["transref"] as! String
                    let status = json?["status"] as! String
                    
                    self.transRefID = transactionRef
                    self.performSegue(withIdentifier: "goToDirection", sender: nil)
                    
                    
                    
                    let date = NSDate()
                    let calendar = NSCalendar.current
                    let day = calendar.component(.day , from: date as Date)
                    let month = calendar.component(.month , from: date as Date)
                    let year = calendar.component(.year , from: date as Date)
                    let hour = calendar.component(.hour, from: date as Date)
                    let minutes = calendar.component(.minute, from: date as Date)
                    let time = "\(hour):\(minutes)"
                    let dmy = "\(day)-\(month)-\(year)"
                    
                    var image = ""
                    if let i = self.transData.image?.absoluteString {
                        image = i
                    }
                    
                    self.ref.child("Traveler").child(self.userId).child("Transactions").child(transactionRef).setValue(["transactionID" : transactionRef, "date" : dmy, "time" : time, "status" : status, "requestedMoney" : self.amountSGD, "fees" : self.fees, "totalCharged" : self.total, "merchantName" : self.transData.name, "merchantAddress" : self.transData.address, "merchLAt" : self.transData.location.latitude, "merchLong" : self.transData.location.longitude, "merchImage" : image, "rating" : self.transData.rating, "merchPhone" : self.transData.merchPhone])
                    
                
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destViewController : NavigationMapViewController = segue.destination as! NavigationMapViewController
        
        if segue.identifier == "goToDirection" {
            
            destViewController.transData = self.transData
            destViewController.transRefID = self.transRefID
        }
        
    }
}
