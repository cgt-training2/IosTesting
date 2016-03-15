//
//  GoogleAPIMapViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 11/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//extension NSURLSessionDataTask{
//    func start(){
//        self.resume()
//    }
//}

class GoogleAPIMapViewController: UIViewController,  NSURLSessionDelegate, NSURLSessionDataDelegate, MKMapViewDelegate {

    @IBOutlet var barButton: UIButton!
    @IBOutlet var foodButton: UIButton!
    @IBOutlet var cafeButton: UIButton!
    @IBOutlet var clubButton: UIButton!
    @IBOutlet var taxiButton: UIButton!
    @IBOutlet var mapViewGoogleAPI: MKMapView!
    
    var latLngArray : NSMutableArray!
    
    var session : NSURLSession!

    var user_lat:Double = 0.0
    
    var user_long:Double = 0.0
    
    var ltLngObject : Json_Object!
    
    var googleApiObject : GooglePlacesApiObjectClass!
    
    var locationManager = CLLocationManager?()
    
    var mutableData : NSMutableData = NSMutableData()
    
    
    var jsonObj : Json_Object!
    
    var myObjArr=[Json_Object]()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.mapViewGoogleAPI = MKMapView()
        /* Create our configuration first */
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 15.0
        // initialize a array
        
        //        var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        mapViewGoogleAPI = MKMapView()
        /* Now create a session that allows us to create the tasks */
        latLngArray = NSMutableArray()
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
    }
    
    // Variables of google Places Api url.
    
    let URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let LOCATION = "location="
    let RADIUS = "radius="
    let TYPES = "types=bar"
    var KEY = "key=" // AIzaSyDD1n1ZN1g50SA51nDOGvyN30qWXi_uIrU (Google API Key)
    
    let radius:Int = 15000
    let apiKey = "AIzaSyDD1n1ZN1g50SA51nDOGvyN30qWXi_uIrU"
    
    var lati:Double = 0.0
    
    var longi:Double = 0.0
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // self.mapViewGoogleAPI.mapType =
       // jsonObj = self.myObjArr[0]
          let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
           lati = appDelegate.locationJsonObj.latitude
           longi = appDelegate.locationJsonObj.Longitude
        
        let urlString = "\(URL)\(LOCATION)\(lati),\(longi)&\(RADIUS)\(radius)&\(TYPES)&\(KEY)\(apiKey)"
        
        print("url String is",urlString)
        
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!)
        
        task.resume()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    // MARK : Function to show alert View.
    
    func displayAlertWithTitle(title: String, message: String){
        
        let controller = UIAlertController(title: "Location Updation", message: "Location Updated", preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func addPinToMapView(){
        googleApiObject = GooglePlacesApiObjectClass()

        for googlePlaceObj in latLngArray{
            
            googleApiObject = googlePlaceObj as! GooglePlacesApiObjectClass
            
                    /* This is location parsed from the api */
            
            let locationCoord = CLLocationCoordinate2D(latitude: googleApiObject.latitude , longitude: googleApiObject.Longitude)
            
          /* Create the annotation using the location */
            
            let annotation = MapAnnotationGoogleApi(coordinate: locationCoord, name: googleApiObject.name, address: googleApiObject.address)
            
            /* And eventually add it to the map */
            
            self.mapViewGoogleAPI.addAnnotation(annotation)

        }
          let locationCoord = CLLocationCoordinate2D(latitude: googleApiObject.latitude , longitude: googleApiObject.Longitude)
        
            setCenterOfMap(locationCoord)
        
    }
    
    
    
    
    // MARK : Session Delegates
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
        data.enumerateByteRangesUsingBlock{
            [weak self] (pointer: UnsafePointer<()>, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
            
            let newData = NSData(bytes: pointer, length: range.length)
            
            self!.mutableData.appendData(newData)
        }
        
       // let dataString = NSString(data: self.mutableData, encoding : NSUTF8StringEncoding)

    //    print("Json Is", dataString)
       
//        let dataJson = dataString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        
        do{
            
            let jsonString = try NSJSONSerialization.JSONObjectWithData(self.mutableData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            if let dictionary = jsonString as? [String: AnyObject]{
                
                if let results = dictionary["results"] as? [AnyObject]{
                    
                    for dictionary2 in results {
                        ltLngObject = Json_Object()
                        
                        googleApiObject = GooglePlacesApiObjectClass()
                        //place_id, reference, scope
                        let latitude = dictionary2["geometry"]?!["location"]?!["lat"]! as? Double
                        let longitude = dictionary2["geometry"]?!["location"]?!["lng"]! as? Double
                        let name = dictionary2["name"] as! String
                        let address = dictionary2["vicinity"] as! String

                        print("Latitude is", latitude)
                        print("longitude is", longitude)
                        print("name is", name)
                        print("address is", address)
                        
                        googleApiObject.name = name
                        
                        googleApiObject.address = address
                        
                        googleApiObject.latitude = latitude!
                        
                        googleApiObject.Longitude = longitude!
                        
                        latLngArray.addObject(googleApiObject)
                    }
                }
            }
          addPinToMapView()
        }
        catch{
            print(error)
        }
    }
    
    
    func setCenterOfMap(location: CLLocationCoordinate2D){
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapViewGoogleAPI.setRegion(region, animated: true)
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
        session.finishTasksAndInvalidate()
        dispatch_async(dispatch_get_main_queue(), {[weak self] in
            var message = "Finished downloading your content"
            if error != nil{
                message = "Failed to download your content"
            }
          //  self!.displayAlertWithTitle("Done", message: message)
            })
        
    }
    
    
    // MARK : MapView Delegate

}
