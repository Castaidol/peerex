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
import AlamofireImage
import Alamofire

class MyTransactionsDetailsViewController: UIViewController, StarRatingViewDelegate {
    
    @IBOutlet weak var ratedView: UIView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var starRatingView: StarRatingView!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var callMerchantBtn: UIButton!
    @IBOutlet weak var reportProblemBtn: UIButton!
    
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchName: UILabel!
    @IBOutlet weak var merchAddress: UILabel!
    @IBOutlet weak var transID: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var requestedSGD: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    var transactionID: String!
    var star: UIImage = UIImage(named: "rate-big-selected.png")!
    var noStar: UIImage = UIImage(named: "rate-big-nonselected.png")!
    var starRate: Int!
    var rating: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        starRatingView.setup(numberOfStars: 5)
        starRatingView.delegate = self
        
        styleView()
        
        ref = FIRDatabase.database().reference()
        ref.child("Traveler").child(userId).child("Transactions").child(transactionID as String).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            
            let value = snapshot.value as? NSDictionary
            
            let requestedCash = value?["requestedMoney"] as? Double
            let transactionID = value?["transactionID"] as? String ?? ""
            let date = value?["date"] as? String ?? ""
            let time = value?["time"] as? String ?? ""
            let address = value?["merchantAddress"] as? String ?? ""
            let name = value?["merchantName"] as? String ?? ""
            let feeMOney = value?["fees"] as? Double
            let totalMoney = value?["totalCharged"] as? Double
            let merchImage = value?["merchImage"] as? String ?? ""
            let ratingSent = value?["ratingSent"] as? Bool
            self.rating = value?["ratingGive"] as? Int
            
            
            
            self.requestedSGD.text = "$\(formatter.string(from: requestedCash! as NSNumber)! )"
            self.merchName.text = name
            self.merchAddress.text = address
            self.transactionDate.text = "\(date), \(time)"
            self.fee.text = "$\(formatter.string(from: feeMOney! as NSNumber)! )"
            self.total.text = "$\(formatter.string(from: totalMoney! as NSNumber)! )"
            self.transID.text = "\(transactionID)"
            if let url = URL(string: merchImage) {
                self.merchImage.af_setImage(withURL: url)
            }
            
            if ratingSent!{
                
                self.ratedLabel.text = "You rated"
                self.callMerchantBtn.isHidden = false
                self.reportProblemBtn.isHidden = false
                self.ratedView.isHidden = false
                self.starRatingView.isHidden = true
                self.rateBtn.isHidden = true
                
                self.showStar()
                
            }else{
               
                self.callMerchantBtn.isHidden = true
                self.reportProblemBtn.isHidden = true
                self.starRatingView.isHidden = false
                self.ratedView.isHidden = true
                self.ratedLabel.text = "Please rate this merchant"
                
                
            }
            
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func showStar(){
        
        if rating! < 2{
            
            self.star1.image = self.star
            self.star2.image = self.noStar
            self.star3.image = self.noStar
            self.star4.image = self.noStar
            self.star5.image = self.noStar
            
            
        }else if rating! >= 2 && rating! < 3 {
            
            self.star1.image = self.star
            self.star2.image = self.star
            self.star3.image = self.noStar
            self.star4.image = self.noStar
            self.star5.image = self.noStar
            
        }else if rating! >= 3 && rating! < 4 {
            
            self.star1.image = self.star
            self.star2.image = self.star
            self.star3.image = self.star
            self.star4.image = self.noStar
            self.star5.image = self.noStar
            
        }else if rating! >= 4 && rating! < 5 {
            
            self.star1.image = self.star
            self.star2.image = self.star
            self.star3.image = self.star
            self.star4.image = self.star
            self.star5.image = self.noStar
            
        }else if rating! == 5 {
            
            self.star1.image = self.star
            self.star2.image = self.star
            self.star3.image = self.star
            self.star4.image = self.star
            self.star5.image = self.star
        }
        
        
    }
    
    func starRatingViewTap(starRatingView: StarRatingView) {
        print (starRatingView.ratingCount)
        
        starRate = starRatingView.ratingCount
    }
    
    func styleView(){
        
        rateBtn.layer.cornerRadius = 5
        callMerchantBtn.layer.cornerRadius = 5
        reportProblemBtn.layer.cornerRadius = 5
        reportProblemBtn.layer.borderWidth = 1
        reportProblemBtn.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    @IBAction func rateBtnAction(){
        
        ratedLabel.text = "You rated"
        rateBtn.isHidden = true
        callMerchantBtn.isHidden = false
        reportProblemBtn.isHidden = false
        starRatingView.isHidden = true
        ratedView.isHidden = false
        
        self.ref.child("Traveler/\(userId)/Transactions/\(transactionID as String)/ratingSent").setValue(true)
        
        
        
         self.ref.child("Traveler/\(userId)/Transactions/\(transactionID as String)/ratingGive").setValue(self.starRate)
        
        print(self.starRate)
        showStar()
        
        self.ref.child("Traveler").child(userId).child("Transactions").child(transactionID as String).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let merchId = value?["merchantID"] as? String ?? ""
            
        
        var parameters: [String: AnyObject] = [:]
        parameters["rating"] = "\(self.starRate)" as AnyObject?
        parameters["transref"] = "\(self.transactionID)" as AnyObject?
        parameters["merchant_id"] = "\(merchId)" as AnyObject?
        
        Alamofire.request("https://boiling-castle-76624.herokuapp.com/ratingapi", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if response.result.value != nil {
                
                let json = response.result.value as? [String: Any]
                
                let rating = json?["rating"] as! Int
                
                self.ref.child("Traveler/\(self.userId)/Transactions/\(self.transactionID as String)/rating").setValue(rating)
 
            }
        }
    })
    }

    

}
