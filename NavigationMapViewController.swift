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

class NavigationMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var merchants: [Merchant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        map.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true


        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        merchants.append(Merchant(name: "Merch 2", location:CLLocationCoordinate2DMake(1.2769667, 103.8434729), status: true, rating: "5.0", image: "hostel2"))
        
       
        
        
        
       // reloadMap()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDirectionsFromCurrentLocation() {
        
        let destinationLocation = merchants[0].location
        
        let sourcePlacemark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.init(red: 33/255, green: 190/255, blue: 130/255, alpha: 1)
        renderer.lineDashPattern = [2, 5]
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
//    func reloadMap(){
//        
//        
//        for x in 0...merchants.count-1 {
//            
//            let merch = merchants[x]
//            
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = merch.location
//            annotation.title = merch.name
//            annotation.subtitle = "\(x)"
//            //            annotation.subtitle = merch.rating
//            
//            map.addAnnotation(annotation)
//            
//        }
 //   }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = manager.location?.coordinate {
            
            print("location updated, setting map region")
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.map.setRegion(region, animated: true)
            
            showDirectionsFromCurrentLocation()
            
        }
    
   }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        if annotation is MKUserLocation {
//            return nil
//        }
//        
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Map Pin")
//        
//        if annotationView == nil {
//            
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Map Pin")
//            //to display the title and subtitle
//            annotationView?.canShowCallout = true
//        }
//        
//        annotationView?.image = UIImage(named: "Pin")
//        
//        
//        return annotationView
//        
//        
//    }



    

}
