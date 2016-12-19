//
//  NavigationMapViewController.swift
//  Peerex
//
//  Created by Gabriele Castaldo on 7/12/16.
//  Copyright © 2016 Gabriele Castaldo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase
import AlamofireImage

class NavigationMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var merchImage: UIImageView!
    @IBOutlet weak var merchName: UILabel!
    @IBOutlet weak var merchAddress: UILabel!
    @IBOutlet weak var transID: UILabel!
    
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var reuseIdentifier = "requestCell"
    
    var transData: Merchant!
    var transRefID:String!
    var destinationLocation: CLLocationCoordinate2D!

    
    var ref: FIRDatabaseReference!
    let userId: String = FIRAuth.auth()!.currentUser!.uid
    let user = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        map.delegate = self
        
        if transData != nil{
            
            if transData.image != nil{
                merchImage.af_setImage(withURL: transData.image!)
            }
            merchName.text = transData.name
            merchAddress.text = transData.address
            transID.text = transRefID
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showDirections(){
        
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let sourcePlacemark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "My position"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Merch"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.map.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }

    
    
        
    }
    
    func showDirectionsFromCurrentLocation() {
        
        if transData != nil{
        
            destinationLocation = transData.location
            
            showDirections()
            
        }else{
            
            ref = FIRDatabase.database().reference()
            ref.child("Traveler").child(userId).child("Transactions").child(transRefID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                let value = snapshot.value as? NSDictionary
                
                let merchName = value?["merchantName"] as? String ?? ""
                let merchAddress = value?["merchantAddress"] as? String ?? ""
                let merchLat = value?["merchLAt"] as? Double
                let merchLong = value?["merchLong"] as? Double
                let merchImage = value?["merchImage"] as? String ?? ""
                
                self.merchName.text = merchName
                self.merchAddress.text = merchAddress
                self.transID.text = self.transRefID
                
                if let url = URL(string: merchImage) {
                    self.merchImage.af_setImage(withURL: url)
                }
                
                self.destinationLocation = CLLocationCoordinate2D(latitude: merchLat!, longitude: merchLong!)
                
                
                self.showDirections()

            })

            
        }
        /*
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let sourcePlacemark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "My position"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Merch"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.map.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }*/
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.init(red: 33/255, green: 190/255, blue: 130/255, alpha: 1)
        renderer.lineDashPattern = [2, 5]
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = manager.location?.coordinate {
            
            print("location updated, setting map region")
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            showDirectionsFromCurrentLocation()
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "goToDetail"{
            
            let destinationDetail : CurrentTransactionDetailsViewController = segue.destination as! CurrentTransactionDetailsViewController
            
            destinationDetail.transRefID = self.transRefID
            
            
        }
        
        
        
    }

}
