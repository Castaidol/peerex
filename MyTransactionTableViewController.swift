//
//  MyTransactionTableViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 23/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyTransactionTableViewController: UITableViewController{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var transactions: [Transaction] = []
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        ref = FIRDatabase.database().reference()
        ref.child("Traveler").child(userId).child("Transactions").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            print(value!)
            
            for trans in value! {
                
                
                
                
                print(trans.key)
                
                self.ref.child("Traveler").child(self.userId).child("Transactions").child(trans.key as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let data = snapshot.value as? NSDictionary
                    
                    let transactionID = data?["transactionID"] as? String ?? ""
                    let status = data?["status"] as? String ?? ""
                    let date = data?["date"] as? String ?? ""
                    let time = data?["time"] as? String ?? ""
                
                    
                    self.transactions.append(Transaction(transactionID: transactionID, value: " evwev", date: date, time: time, fee: "ecewew", address: "wvewvwe", merchName: "efwe", status: status, totalCost: "efewgrg"))
                    
                    print(self.transactions)
                
                    //print(transactions)
                    
                    self.tableView.reloadData()
                })
                
                
                
            }
            
        })

        /*
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "22/11/2016", time: "10:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed", totalCost: "2"))
        transactions.append(Transaction(transactionID: "trans1", value: "25.00", date: "26/11/2016", time: "13:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed", totalCost: "2"))
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "24/11/2016", time: "9:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed", totalCost: "2"))
        transactions.append(Transaction(transactionID: "trans1", value: "100.00", date: "6/11/2016", time: "10:30", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed", totalCost: "2"))
        transactions.append(Transaction(transactionID: "trans1", value: "50.00", date: "12/11/2016", time: "11:00", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Failed", totalCost: "2"))
        transactions.append(Transaction(transactionID: "trans1", value: "35.00", date: "19/11/2016", time: "22:15", fee: "1.20", address: "somewhere", merchName: "merchant Name Here", status: "Completed", totalCost: "2"))
        */
        //print(transactions)
        
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


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
