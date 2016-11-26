//
//  Transaction.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 26/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import Foundation

class Transaction{
    
    var transactionID: String
    var date: String
    var time: String
    var fee: String
    var address: String
    var merchName: String
    
    init(transactionID: String, date: String, time: String, fee: String, address: String, merchName: String) {
        
        self.transactionID = transactionID
        self.date = date
        self.time = time
        self.fee = fee
        self.address = address
        self.merchName = merchName
        
    }
    
}
