//
//  MyTransactionTableViewCell.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 26/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class MyTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var sgdValue: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var merchName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell (transaction: Transaction){
        
        self.sgdValue.text = transaction.value
        self.status.text = transaction.status
        self.date.text = transaction.date
        self.time.text = transaction.time
        self.merchName.text = transaction.merchName
        self.address.text = transaction.address
        self.fee.text = transaction.fee
        self.transactionID.text = transaction.transactionID
        
    }

}
