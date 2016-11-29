//
//  ApplePayTestViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 26/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import PassKit

class ApplePayTestViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var amountToPurchaseLabel: UILabel!
    
    var amountSGD = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }


        amountToPurchaseLabel.text = "\(amountSGD)SGD"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addValue(_ sender: Any) {
        
        if amountSGD < 100 {
            amountSGD += 5
        
            amountToPurchaseLabel.text = "\(amountSGD)SGD"
        }else{
            
            print("100SGD is the max amount")
        }
        
    }
    @IBAction func subtractValue(_ sender: Any) {
        
        if amountSGD > 5 {
            amountSGD -= 5
        
            amountToPurchaseLabel.text = "\(amountSGD)SGD"
        }
    }
    
    
    
    @IBAction func doPayment(){
        
        let paymentRequest = PKPaymentRequest()
        
        let supportedNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]
        let merchantId = "merchant.alphacampsg.peerex"
        
        paymentRequest.merchantIdentifier = merchantId
        paymentRequest.supportedNetworks = supportedNetworks
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "SG"
        paymentRequest.currencyCode = "SGD"
        
        let item = PKPaymentSummaryItem(label: "Purchase SGD \(amountSGD)", amount: NSDecimalNumber(value: amountSGD))
        paymentRequest.paymentSummaryItems = [item]
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        applePayController.delegate = self
        
        self.present(applePayController, animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationViewController) {
        
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect paymentMethod: PKPaymentMethod, completion: @escaping ([PKPaymentSummaryItem]) -> Void) {
        
    }
    
}
