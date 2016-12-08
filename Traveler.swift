//
//  Traveler.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 28/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import Foundation

class Traveler{
    
    var firstName: String
    var lastName: String
    //var creditCard: CreditCard
    var photo: String
    var mobileNumber: String
    var userId: String
    
    init(firstName: String, lastName: String, photo: String, mobileNumber: String, userId: String){
        
        self.firstName = firstName
        self.lastName = lastName
//        self.creditCard = creditCard
        self.photo = photo
        self.mobileNumber = mobileNumber
        self.userId = userId
        
    }
}
