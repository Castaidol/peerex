//
//  CreditCard.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 28/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import Foundation

class CreditCard{
    
    var firstName: String
    var lastName: String
    var number: String
    var expDate: String
    var cardVerificationValue: String
    
    init(firstName: String, lastName: String, number: String, expDate: String, cardVerificationValue: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.expDate = expDate
        self.cardVerificationValue = cardVerificationValue
        
    }
    
    
}
