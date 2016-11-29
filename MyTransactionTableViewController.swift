//
//  MyTransactionTableViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 23/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit

class MyTransactionTableViewController: UITableViewController{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var transactions: [Transaction] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "22/11/2016", time: "10:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed"))
        transactions.append(Transaction(transactionID: "trans1", value: "25.00", date: "26/11/2016", time: "13:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed"))
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "24/11/2016", time: "9:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed"))
        transactions.append(Transaction(transactionID: "trans1", value: "100.00", date: "6/11/2016", time: "10:30", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed"))
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "12/11/2016", time: "11:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Failed"))
        transactions.append(Transaction(transactionID: "trans1", value: "35.00", date: "19/11/2016", time: "22:15", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed"))
        
            
        
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MyTransactionTableViewCell
        
        let transaction = transactions[indexPath.row]
        
        cell.configureCell(transaction: transaction)
        return cell
        
    }
    
}
