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

class CoreMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var pickUpImage: UIImageView!
    @IBOutlet weak var pickUpReference: UILabel!
    @IBOutlet weak var pickUpStreet: UILabel!
    @IBOutlet weak var pickUpName: UILabel!
    @IBOutlet weak var pickUpView: UIView!
    @IBOutlet weak var confirmRate: UILabel!
    @IBOutlet weak var confirmImage: UIImageView!
    @IBOutlet weak var confirmDist: UILabel!
    @IBOutlet weak var confirmStreet: UILabel!
    @IBOutlet weak var confirmName: UILabel!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var moneyRequestLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    
    var merchants: [Merchant] = []
    
    var amountSGD = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmView.isHidden = true
        pickUpView.isHidden = true
        requestView.isHidden = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
            
        }
        
        moneyRequestLabel.text = "\(amountSGD)SGD"
        
        merchants.append(Merchant(name: "Merch 1", location: CLLocationCoordinate2DMake(1.2768626, 103.8431314), status: true, rating: "4.0"))
        merchants.append(Merchant(name: "Merch 2", location:CLLocationCoordinate2DMake(1.2769667, 103.8434729), status: true, rating: "5.0"))
        merchants.append(Merchant(name: "Merch 3", location:CLLocationCoordinate2DMake(1.278796, 103.841442), status: false, rating: "1.3"))
        merchants.append(Merchant(name: "Merch 4", location:CLLocationCoordinate2DMake(1.276569, 103.842083), status: true, rating: "4.2"))

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = manager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            
            self.map.setRegion(region, animated: true)
            
            
        }
        
    }
    
    
    func reloadMap(){
        
        //clear current annotations
        //mainMap.removeAnnotations(mainMap.annotations)
        
        //create new annotations for the array
        
        for x in 0...merchants.count-1 {
            
            let merch = merchants[x]
            
            let venueDict = merch
            let venueName = venueDict.name
            let location = venueDict.location
            let rating = venueDict.rating
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = venueName
            annotation.subtitle = rating
            
            map.addAnnotation(annotation)
            
            
        }
    }


    @IBAction func addValue(_ sender: Any){
        
        if amountSGD < 100 {
            amountSGD += 5
            
            moneyRequestLabel.text = "\(amountSGD)SGD"
        }else{
            
            print("100SGD is the max amount")
        }

        
    }
    @IBAction func subValue(_ sender: Any){
        
        if amountSGD > 5 {
            amountSGD -= 5
            
            moneyRequestLabel.text = "\(amountSGD)SGD"
        }else{
            
        }

        
    }
    @IBAction func requestMoney(_ sender: Any){
        
        reloadMap()
        
        confirmView.isHidden = false
        pickUpView.isHidden = true
        requestView.isHidden = true
        
        

        
    }
    @IBAction func confirmPickUp(_ sender: Any) {
        
        pickUpView.isHidden = false
        confirmView.isHidden = true
        requestView.isHidden = true
        
        
    }
    @IBAction func moreInfo(_ sender: Any) {
        
        
        
        
    }
    
    
}
