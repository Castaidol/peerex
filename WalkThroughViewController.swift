//
//  WalkThroughViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 3/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseAuth

class WalkThroughViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var walkThroughCollectionView: UICollectionView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    
    let reuseIdentifier = "WalkCell"
    
    
    let walkThroughImageArray = ["icon-line-creditcard", "icon-line-cash", "icon-line-pinmap", "icon-line-trustedmerchants"]
    
    let walKThroughTextArray = ["Buy local Currency from a nearby Peerex merchant with your credit card. It's like having a network of human-powered ATMs around you", "Specify the cash amount you need", "Select one of our authorized merchants near you", "Pick up cash from the merchant’s location. The merchant will be paid automatically via your credit card"]
    
    let walkThroughTitleArray = ["What is Peerex?", "How it works?", "How it works?", "How it works?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        
            }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if FIRAuth.auth()?.currentUser != nil{
            self.performSegue(withIdentifier: "GoToMainPage", sender: nil)
            
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return walkThroughImageArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WalkThroughCollectionViewCell
        
        let idx =  indexPath.row
        let fileName = walkThroughImageArray[idx]
        let WalkImage = UIImage(named: fileName)
        cell.walkThroughImage.image = WalkImage
        
        let text = walKThroughTextArray[idx]
        cell.WalKThroughLabel.text = text
        
        let title = walkThroughTitleArray[idx]
        cell.WalKThroughTitleLabel.text = title
        
        return cell
        
    }
    
    func styleView(){
        
        let minimumSpace = walkThroughCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        minimumSpace.minimumLineSpacing = 0
        
        logInButton.layer.cornerRadius = 5
        singUpButton.layer.borderWidth = 1
        singUpButton.layer.borderColor = UIColor.black.cgColor
        singUpButton.layer.cornerRadius = 5
        
    }
    
    
    

    
    
}
