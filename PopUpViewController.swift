//
//  PopUpViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 12/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var amountMoney: UILabel!
    @IBOutlet weak var merchNAme: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
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
