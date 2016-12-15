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
//import FirebaseAuth
//import FirebaseDatabase
import Alamofire

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
    var idx: Int = 0
    
    var amountSGD = 20.00
    
    var selectedIndex: IndexPath?
    
//    var ref: FIRDatabaseReference!
//    let userId: String = FIRAuth.auth()!.currentUser!.uid
//    var refHandle: UInt!
//    let user = FIRAuth.auth()?.currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        
        
        let pinchGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        pinchGesture.minimumPressDuration = 1
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
        
        Alamofire.request("https://boiling-castle-76624.herokuapp.com/merchants", method: .get).responseJSON { (response) in
            
            if let JSON = response.result.value {

                
                let arrayOfMerchants = JSON as! [[String: Any]]
                
                for merchant in arrayOfMerchants {
                    
                    var merchantImage: String?
                    var merchantName: String?
                    var merchAddress: String?
                    var merchantStatus: Bool?
                    var merchantRating: Float?
                    var merchantLat: Double?
                    var merchantLong:Double?
                    
                    if merchant["merchant_name"] != nil {
                        
                        merchantName = merchant["merchant_name"] as? String
                    
                    }
                    if merchant["merchant_address"] != nil {
                        
                        merchAddress = merchant["merchant_address"] as? String
                    
                    }
                    if merchant["merchant_status"] != nil {
                        
                        merchantStatus = merchant["merchant_status"] as? Bool
                        
                    }
                    if merchant["merchant_avatar"] != nil {
                        
                        merchantImage = merchant["merchant_avatar"] as? String
                        
                    }
                    if merchant["merchant_rating"] != nil {
                    
                        merchantRating = merchant["merchant_rating"] as? Float
                    }
                    
                    let merchantRatingStr = "\(merchantRating)"
                    
                    if merchant["lat"] != nil {
                        
                        merchantLat = merchant["lat"] as? Double
                    }
                    if merchant["long"] != nil {
                        merchantLong = merchant["long"] as? Double
                    }
                    
                    
                    self.merchants.append(Merchant(name: merchantName!, location: CLLocationCoordinate2DMake(merchantLat!, merchantLong!), status: merchantStatus!, rating: merchantRatingStr, image: merchantImage, address: merchAddress!))
                    
                }
            }
            
            for merch in self.merchants{
                
                print(merch.name)
                print(merch.location)
                print(merch.status)
            }
            self.reloadMap()
            self.collectionMerch.reloadData()
        }

        /*
        merchants.append(Merchant(name: "Merch 1", location: CLLocationCoordinate2DMake(1.2768626, 103.8431314), status: true, rating: "4.0", image: "hostel1"))
        merchants.append(Merchant(name: "Merch 2", location:CLLocationCoordinate2DMake(1.2769667, 103.8434729), status: true, rating: "5.0", image: "hostel2"))
        merchants.append(Merchant(name: "Merch 3", location:CLLocationCoordinate2DMake(1.278796, 103.841442), status: false, rating: "1.3", image: "hostel3"))
        merchants.append(Merchant(name: "Merch 4", location:CLLocationCoordinate2DMake(1.276569, 103.842083), status: true, rating: "4.2", image: "hostel4"))
        
        reloadMap()*/
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
       
        
        for mer in 0...merchants.count-1 {
            
            let merch = merchants[mer]
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = merch.location
            annotation.title = merch.name
            annotation.subtitle = "\(mer)"
        
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
            annotationView?.canShowCallout = false
        }
        
        annotationView?.image = UIImage(named: "Pin")
        
        return annotationView
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation
        let index = Int(annotation!.subtitle!!)
        
        view.image = UIImage(named: "Pin2")
        let ip = IndexPath(item: index!, section: 0)
        selectedIndex = ip
        collectionMerch.reloadData()
        collectionMerch.scrollToItem(at: ip, at: .centeredHorizontally, animated: true)
        
        
        
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        view.image = UIImage(named: "Pin")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        let merch = merchants.count
        return merch
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MerchantMapCollectionViewCell
        
        let merch = merchants[indexPath.row]

        cell.configureCell(merchant: merch)
        if indexPath == selectedIndex {
            cell.selectView.backgroundColor = UIColor.init(red: 33/255, green: 190/255, blue: 130/255, alpha: 1)
        } else {
            cell.selectView.backgroundColor = .white

        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destViewController : DetailTransactionViewController = segue.destination as! DetailTransactionViewController
        
        let indexPath = collectionMerch.indexPath(for: sender as! UICollectionViewCell)
        
        if segue.identifier == "showDetail" {
            
            let myMerchant = self.merchants[(indexPath?[1])!]
            let sendAmount = self.amountSGD
            print("valud of idx is \((indexPath?[1])!)")
            destViewController.transData = myMerchant
            destViewController.amountSGD = sendAmount
        }
        
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        if amountSGD < 100 {
            
            amountSGD += 10.00
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            amounMoney.text = "$\(formatter.string(from: amountSGD as NSNumber)!)"
        }
        
    }
    
    @IBAction func minusButton(_ sender: Any){
        
        if amountSGD > 10 {
            
            amountSGD -= 10.00
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            amounMoney.text = "$\(formatter.string(from: amountSGD as NSNumber)!)"
            
        }
        
    }
    
    @IBAction func cancelStreetButton(_ sender: Any){
        
        streetTextField.text = ""
        
    }
    
    func styleView(){
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        amounMoney.text = "$\(formatter.string(from: amountSGD as NSNumber)!)"
        
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
