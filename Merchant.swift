//
//  Merchant.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 28/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import Foundation
import CoreLocation

class Merchant{
    
    var name: String
    var location: CLLocationCoordinate2D
    var status: Bool
    var rating: Float
    var image: URL?
    var address: String
    var merchID: String
    var merchPhone: String
    
    init(name: String, location: CLLocationCoordinate2D, status: Bool, rating: Float, image: URL?, address: String, merchID: String, merchPhone: String) {
        
        
        self.name = name
        self.location = location
        self.status = status
        self.rating = rating
        self.address = address
        self.merchID = merchID
        self.merchPhone = merchPhone
        
        if let image = image {
            self.image = image
        }
        
    }
    
    
    
}
