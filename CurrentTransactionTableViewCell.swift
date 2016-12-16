//
//  CurrentTransactionTableViewCell.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 16/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class CurrentTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var merchantImage: UIImageView!
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantAddress: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
