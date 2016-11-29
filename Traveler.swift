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
    var creditCard: CreditCard
    var photo: String
    
    init(firstName: String, lastName: String, creditCard: CreditCard, photo: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.creditCard = creditCard
        self.photo = photo
        
    }
}
