//
//  CoreMapViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 23/11/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import FirebaseDatabase

class CoreMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionMerch: UICollectionView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var amounMoney: UILabel!
    @IBOutlet weak var moneyView: UIView!
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var streetView: UIView!
    
    let reuseIdentifier = "Cell"
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    
    var merchants: [Merchant] = []
    var idx: Int? = 0
    
    var amountSGD = 20
    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    var refHandle: UInt!
    let user = FIRAuth.auth()?.currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        
        
        let pinchGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        pinchGesture.minimumPressDuration = 2
        map.addGestureRecognizer(pinchGesture)
        
        map.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        


        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
            
        }
//        
//        ref = FIRDatabase.database().reference()
//        let merchantRef = ref.child("Merchant")
//        
//        merchantRef.observe(.childAdded, with: { (snapshot) in
//        
//            print(snapshot.value!)
//            
//            
//            
//        })
//        
//        refHandle = ref.observe(FIRDataEventType.value, with: { (snapshot) in
//            
//            
//        })
//
//        ref.child("Traveler").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            let value = snapshot.value as? NSDictionary
//            let firstName = value?["firstName"] as? String ?? ""
//            let lastName = value?["lastName"] as? String ?? ""
//            let phoneNumber = value?["phoneNumber"] as? String ?? ""
//            self.firstNameText.text = firstName
//            self.lastNameText.text = lastName
//            self.phoneNumber.text = phoneNumber
//            
//        })

        
        
//        merchants.append(Merchant(name: "Merch 1", location: CLLocationCoordinate2DMake(1.2768626, 103.8431314), status: true, rating: "4.0", image: "hostel1"))
//        merchants.append(Merchant(name: "Merch 2", location:CLLocationCoordinate2DMake(1.2769667, 103.8434729), status: true, rating: "5.0", image: "hostel2"))
//        merchants.append(Merchant(name: "Merch 3", location:CLLocationCoordinate2DMake(1.278796, 103.841442), status: false, rating: "1.3", image: "hostel3"))
//        merchants.append(Merchant(name: "Merch 4", location:CLLocationCoordinate2DMake(1.276569, 103.842083), status: true, rating: "4.2", image: "hostel4"))
        
        

//        reloadMap()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        reloadMap()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = manager.location?.coordinate {
            
            print("location updated, setting map region")
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
        }
        
    }
    
    
    func reloadMap(){
       
        
        for x in 0...merchants.count-1 {
            
            let merch = merchants[x]
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = merch.location
            annotation.title = merch.name
            annotation.subtitle = "\(x)"
        
            map.addAnnotation(annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Map Pin")
        
        if annotationView == nil {
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Map Pin")
            //to display the title and subtitle
            annotationView?.canShowCallout = true
        }
        
        annotationView?.image = UIImage(named: "Pin")
        
        return annotationView
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation
        let index = Int(annotation!.subtitle!!)
        
        collectionMerch.scrollToItem(at: IndexPath(item: index!, section: 0), at: .centeredHorizontally, animated: true)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        let merch = merchants.count
        return merch
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MerchantMapCollectionViewCell
        
        let merch = merchants[indexPath.row]
        
        cell.configureCell(merchant: merch)
        return cell

    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return 1
    }
    
    func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == . ended {
            
            if collectionMerch.isHidden{
                
                collectionMerch.isHidden = false
                
            }else{
                
                collectionMerch.isHidden = true
                
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        idx = indexPath.row
        print("valud of idx at idxpath is \(idx)")

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destViewController : DetailTransactionViewController = segue.destination as! DetailTransactionViewController
        
        let my_merchant = self.merchants[idx!]
        print("valud of idx is \(idx)")
        destViewController.transData = my_merchant
        
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        if amountSGD < 100 {
            
            amountSGD += 10
            
            amounMoney.text = "$\(amountSGD)"
        }
        
    }
    
    @IBAction func minusButton(_ sender: Any){
        
        if amountSGD > 10 {
            
            amountSGD -= 10
            
            amounMoney.text = "$\(amountSGD)"
        }
        
    }
    
    @IBAction func cancelStreetButton(_ sender: Any){
        
        streetTextField.text = ""
        
    }
    
    func styleView(){
        
        amounMoney.text = "$\(amountSGD)"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        collectionMerch.isHidden = false
        collectionMerch.delegate = self
        collectionMerch.allowsSelection = true

        
        streetTextField.borderStyle = UITextBorderStyle.none
        moneyView.layer.cornerRadius = 5
        streetView.layer.cornerRadius = 5
        
        
    }

}
