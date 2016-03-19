//
//  LocationManagerViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 01/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class LocationManagerViewController: UIViewController, CLLocationManagerDelegate
{
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet var latitudeLabel1: UILabel!
    @IBOutlet var longitudeLabel1: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var locationManager = CLLocationManager?()
    
    var jsonObj = Json_Object()
    
    var myObjArr=[Json_Object]()
    //public static
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Navigate", style: .Plain, target: self, action: "performAdd:")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Navigate", style: .Plain, target: self, action: "navigate:")
        
    }
    
      //mapViewStory
    
    func navigate(sender:UIBarButtonItem){
        
        
        let mapView = self.storyboard?.instantiateViewControllerWithIdentifier("mapSingle") as! MapSingleAnnotationViewController
//       let mapView = self.storyboard?.instantiateViewControllerWithIdentifier("googleAPIMap") as! GoogleAPIMapViewController
//             mapView.jsonObj = self.jsonObj
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
   override func viewDidAppear(animated: Bool) {
    
        super.viewDidAppear(animated)
    
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
        
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            
                case .AuthorizedAlways:
                     /* Yes, always. */
                    createLocationManager(startImmediately: true)
                break
            
                case .AuthorizedWhenInUse:
                     /* Yes, only when our app is in use. */
                    createLocationManager(startImmediately: true)
                break
        
                case .Denied:
                    /* No. */
                    displayAlertWithTitle("not Determined", message: "Location Services are not allowed for this app")
                break
        
                case .NotDetermined:
                    /* We don't know yet; we have to ask */
                    createLocationManager(startImmediately: false)
                        if let manager = self.locationManager{
                            manager.requestWhenInUseAuthorization()
                        }
                break
                case .Restricted:
                    /* Restrictions have been applied; we have no access to location services. */
                    displayAlertWithTitle("Restricted", message: "location Services not allowed for this app")
                break
            
            }
        }
        else{
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the user to enable the location services. */
                print("Location Services are not enabled")
        }
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func createLocationManager(startImmediately startImmediately: Bool){
        locationManager = CLLocationManager()
            if let manager = locationManager{
                print("Successfully created the location manager");
        
                manager.delegate = self
        
                if startImmediately{
                    manager.startUpdatingLocation()
                }
            }
    }
    
    
    // It’s also handy to create a method that displays an alert view to the user with a specific title and message. We will use the following method to display an alert view to the user whenever there is a problem with the authorization status of location services on her device :
    
    func displayAlertWithTitle(title: String, message: String){
        
        let controller = UIAlertController(title: "Location Updation", message: "Location Updated", preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
    // MARK: Location Manager Delegate Methods:

    
    // This method, as its name implies, gets called on the delegate as soon as the authorization status of your location manager is changed by the user. Here is a simple implementation of this method :
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        print("The authorization status of location services is changed to:")
        
            switch CLLocationManager.authorizationStatus(){
            
                case .AuthorizedAlways:
                    /* Yes, always. */
                    print("Authorized")
                break
            
                case .AuthorizedWhenInUse:
                    /* Yes, only when our app is in use. */
                    //createLocationManager(startImmediately: true)
                    print("Authorized when in use")
                break
            
                case .Denied:
                    /* No. */
                    //displayAlertWithTitle("not Determined", message: "Location Services are not allowed for this app")
                    print("Denied")
                break
            
                case .NotDetermined:
                    /* We don't know yet; we have to ask */
                    print("Not Determined")
                break
                
                case .Restricted:
                    /* Restrictions have been applied; we have no access to location services. */
                    //displayAlertWithTitle("Restricted", message: "location Services not allowed for this app")
                    print("Restricted")
                break
            
        }
    }
    
    
    // which will get called whenever an error occurs on your location manager, such as a failure to retrieve the user’s location.
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Manager failed with error =\(error)")
    }
    
    
    // which gets called on the delegate whenever the location manager object has received a location update for the user.
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {

        
        // User Latitude and Longitude.
        let user_lat = String(format: "%f", newLocation.coordinate.latitude)
        let user_long = String(format: "%f", newLocation.coordinate.longitude)

        self.jsonObj.latitude = newLocation.coordinate.latitude
        self.jsonObj.Longitude = newLocation.coordinate.longitude
        
        // adding the Object to the array.
        
        //self.myObjArr[0] = self.jsonObj
        
        // Set text of user Latitude and longitude.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.locationJsonObj = self.jsonObj
      //  print("Latitude is \(newLocation.coordinate.latitude)")
       // print("Longitude is \(newLocation.coordinate.longitude)")
        latitudeLabel1.text = user_lat
        longitudeLabel1.text = user_long
    }
    
}



