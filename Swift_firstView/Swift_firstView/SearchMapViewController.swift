//
//  SearchMapViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 03/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class SearchMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //var mapView: MKMapView!
    var mapView: MKMapView!
    //var locationManager = CLLocationManager?()
    var locationManager = CLLocationManager?()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        mapView = MKMapView()
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        mapView.delegate = self
        print("::::::::::SearchMapViewController ViewDidLoad()::::::::::")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("::::::::::SearchMapViewController ViewDidAppear()::::::::::")
         /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            
                case .AuthorizedAlways:
                    print("Authorized")
                    break
                
                case .Denied:
                    /* No */
                    displayAlertWithTitle("Not Determined", message: "Location Services Not allowed for the app")
                    break
                
                case .NotDetermined:
                    /* We don't know yet; we have to ask */
                    locationManager = CLLocationManager()
                    if let manager = locationManager{
                        manager.requestWhenInUseAuthorization()
                    }
                    break
                
                case .Restricted:
                    /* Restrictions have been applied; we have no access to location services */
                    displayAlertWithTitle("restricted", message: "Location services are not allowed for this app")
                    break
                
                default:
                    showUserLocationOnMapView()
            }
        
        }
        else{
            /* Location services are not enabled. Take appropriate action: for instance, prompt the user to enable the location services. */
                print("location services are not enabled ")
        }
        
    }
    
    
    // MARK : Location Delegate
    
    /* The authorization status of the user has changed; we need to react to that so
    that if she has authorized our app to to view her location, we will accordingly attempt to do so */

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        print("The authorization status of location services is changed to: ")
        
        switch CLLocationManager.authorizationStatus(){
            
            case .Authorized:
                print("Authorized")
            case .AuthorizedWhenInUse:
                print("Authorized when in use")
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
        
        }

    }
    
    
    func displayAlertWithTitle(title: String, message: String){
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    
    /* We call this method when we are sure that the user has given us access to her location */
    
    func showUserLocationOnMapView(){
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
        
    }
    
    // MARK: MapView Delegate
    
    
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
            displayAlertWithTitle("failed", message: "Could not get the user's location")
    }
    
    
    
//    let request = MKLocalSearchRequest()
//    request.naturalLanguageQuery = "Pizza"
//    request.region = mapView.region
//    
//    let search = MKLocalSearch(request: request)
//    
//    search.startWithCompletionHandler(
//    {(response: MKLocalSearchResponse!,
//    error: NSError!) in
//    
//    if error != nil {
//    println("Error occured in search: \(error.localizedDescription)")
//    } else if response.mapItems.count == 0 {
//    println("No matches found")
//    } else {
//    println("Matches found")
//    
//    for item in response.mapItems as! [MKMapItems] {
//    println("Name = \(item.name)")
//    println("Phone = \(item.phoneNumber)")
//    }
//    }
//    })
    
//    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    
//    let region = MKCoordinateRegion(center: location, span: span)
//    
//    mapView.setRegion(region, animated: true)
    
//        func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
//    
//                    let request = MKLocalSearchRequest()
//                      
//                    let purpleLocation = CLLocationCoordinate2D(latitude: 58.592737, longitude: 16.185898)
//    
//                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    
//                    request.naturalLanguageQuery = "restaurants"
//    
//                    let region = MKCoordinateRegion(center: purpleLocation, span: span)
//    
//                    mapView.setRegion(region, animated: true)
//    
//                    request.region = mapView.region
//    
//                    let search = MKLocalSearch(request: request)
//    
//                    search.startWithCompletionHandler{ (response: MKLocalSearchResponse!, error: NSError!) in for
//    }
//                    request.region = MKCoordinateRegion(center: userLocation.location!.coordinate, span: span)
//    
//                    let search = MKLocalSearch(request: request)
//    
//                    search.startWithCompletionHandler{
//                        (response: MKLocalSearchResponse!, error: NSError!) in for item in response.mapItems as [MKMapItem]{
//    
//                            print("Item Name = \(item.name)")
//                            print("Item PhoneNumber = \(item.phoneNumber)")
//                            print("Item Url = \(item.url)")
//                            print("Item Location = \(item.placemark.location)")
//                        }
//                    }
//        }

}
