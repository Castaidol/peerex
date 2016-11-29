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
    var value: String
    var date: String
    var time: String
    var fee: String
    var address: String
    var merchName: String
    var status: String
    
    init(transactionID: String,value: String, date: String, time: String, fee: String, address: String, merchName: String, status: String) {
        
        self.transactionID = transactionID
        self.value = value
        self.date = date
        self.time = time
        self.fee = fee
        self.address = address
        self.merchName = merchName
        self.status = status
        
    }
    
}
