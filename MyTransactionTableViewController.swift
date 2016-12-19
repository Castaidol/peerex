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
            
            if value != nil{
            for trans in value! {
                
                
                self.ref.child("Traveler").child(self.userId).child("Transactions").child(trans.key as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let data = snapshot.value as? NSDictionary
                    
                    let transactionID = data?["transactionID"] as? String ?? ""
                    let status = data?["status"] as? String ?? ""
                    let date = data?["date"] as? String ?? ""
                    let time = data?["time"] as? String ?? ""
                    let address = data?["merchantAddress"] as? String ?? ""
                    let name = data?["merchantName"] as? String ?? ""
                    let requestedMoney = data?["requestedMoney"] as? Double
                    let feeMOney = data?["fees"] as? Double
                    let totalMoney = data?["totalCharged"] as? Double
                    
                
                    
                    self.transactions.append(Transaction(transactionID: transactionID, value: String(describing: requestedMoney!), date: date, time: time, fee: String(describing: feeMOney!), address: address, merchName: name, status: status, totalCost: String(describing: totalMoney!)))
                    
                    
                    self.tableView.reloadData()
                })
                
                }}
            
        })

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : MyTransactionsDetailsViewController = segue.destination as! MyTransactionsDetailsViewController
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        
        if segue.identifier == "showTransDetail" {
            
            let transactionID = transactions[(indexPath?.row)!].transactionID
            
            destViewController.transactionID = transactionID
        }

    }
    
}
