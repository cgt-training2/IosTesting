//
//  GoogleAPIMapViewControllerWithButtonTag.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 15/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

class GoogleAPIMapViewControllerWithButtonTag: UIViewController, NSURLSessionDelegate, NSURLSessionDataDelegate, MKMapViewDelegate {
    
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
    
    var task : NSURLSessionDataTask!
    
    var jsonObj : Json_Object!
    
    var myObjArr=[Json_Object]()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.mapViewGoogleAPI = MKMapView()
        
        task = NSURLSessionDataTask()
        /* Create our configuration first */
        
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        
//        configuration.timeoutIntervalForRequest = 15.0
        
        // initialize a array
        
        //        var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        mapViewGoogleAPI = MKMapView()
        /* Now create a session that allows us to create the tasks */
        
        latLngArray = NSMutableArray()
        
//        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
    }
    
    // Variables of google Places Api url.
    
    let URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    let LOCATION = "location="
    let RADIUS = "radius="
    let TYPES = "types="
    var KEY = "key=" // AIzaSyDD1n1ZN1g50SA51nDOGvyN30qWXi_uIrU (Google API Key)
    
    let radius:Int = 15000
    let apiKey = "AIzaSyDD1n1ZN1g50SA51nDOGvyN30qWXi_uIrU"
    
    var lati:Double = 0.0
    
    var longi:Double = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        lati = appDelegate.locationJsonObj.latitude
        longi = appDelegate.locationJsonObj.Longitude
        
        // Set the tag value of buttons.
        
        self.barButton.tag = 1
        
        self.foodButton.tag = 2
        
        self.cafeButton.tag = 3
        
        self.clubButton.tag = 4
        
        self.taxiButton.tag = 5
        
         navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigateBtn:")
        
//        let urlString = "\(URL)\(LOCATION)\(lati),\(longi)&\(RADIUS)\(radius)&\(TYPES)&\(KEY)\(apiKey)"
        
//        print("url String is",urlString)
       
//        let url = NSURL(string: urlString)
        
//        let task = session.dataTaskWithURL(url!)
        
//        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK : Function to show alert View.
    
    func displayAlertWithTitle(title: String, message: String){
        
        let controller = UIAlertController(title: "Location Updation", message: "Location Updated", preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func addPinToMapView(){
        
   //Remove any existing custom annotations but not the user location blue dot.
        
        for annotation in self.mapViewGoogleAPI.annotations{
        
            if annotation.isKindOfClass(MapAnnotationGoogleApi){
                self.mapViewGoogleAPI.removeAnnotation(annotation)
            }
        }
        
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
        self.mapViewGoogleAPI.delegate = self
        let locationCoord = CLLocationCoordinate2D(latitude: googleApiObject.latitude , longitude: googleApiObject.Longitude)
        
        setCenterOfMap(locationCoord)
    }
    
    // MARK : Session Delegates
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
//       self.mutableData.setData(NSData())
//        data.enumerateByteRangesUsingBlock{
//            [weak self] (pointer: UnsafePointer<()>, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
//            
//            let newData = NSData(bytes: pointer, length: range.length)
//            
//            self!.mutableData.appendData(newData)
//        }
//        
//
//        self.latLngArray.removeAllObjects()
//        
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
    
    func setTypeInAPI(type: NSString){
        
       // let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 15.0
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let type1 = type
        
        let urlString = "\(URL)\(LOCATION)\(lati),\(longi)&\(RADIUS)\(radius)&\(TYPES)\(type1)&\(KEY)\(apiKey)"
        
        print("url String is",urlString)
        
        let url = NSURL(string: urlString)
//
//        task = session.dataTaskWithURL(url!)
        
         task = session.dataTaskWithURL(url!, completionHandler: {
            
            [weak self] (data: NSData?,response: NSURLResponse?, error: NSError?) in
         
            var jsonString : NSDictionary!
             self!.latLngArray.removeAllObjects()
            do{
                
                  jsonString = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                if let dictionary = jsonString as? [String: AnyObject]{
                    
                                    if let results = dictionary["results"] as? [AnyObject]{
                    
                                        for dictionary2 in results {

                                            self!.googleApiObject = GooglePlacesApiObjectClass()
                                            let latitude = dictionary2["geometry"]?!["location"]?!["lat"]! as? Double
                                            let longitude = dictionary2["geometry"]?!["location"]?!["lng"]! as? Double
                                            let name = dictionary2["name"] as! String
                                            let address = dictionary2["vicinity"] as! String
                    
                                            print("Latitude is", latitude)
                                            print("longitude is", longitude)
                                            print("name is", name)
                                            print("address is", address)
                    
                                            self!.googleApiObject.name = name
                    
                                            self!.googleApiObject.address = address
                                            
                                            self!.googleApiObject.latitude = latitude!
                                            
                                            self!.googleApiObject.Longitude = longitude!
                                            
                                            self!.latLngArray.addObject(self!.googleApiObject)
                                        }
                                    }
                       }
                
                // Clearing the queue from the background thread.
                
                dispatch_async(dispatch_get_main_queue(), {
                    // code here
                    self!.addPinToMapView()
                })
                
                /* giving problem of AutoLayout in devices */
                
               // self!.addPinToMapView()
                
            }catch{
                print(error)
            }
                if((jsonString == nil)){
                    return
                }
            })
        task.resume()
    }
    
    @IBAction func buttonTypeAction(sender: AnyObject) {
        
        if(sender.tag == 1)
        {
            setTypeInAPI("bar")
        }
        else if(sender.tag == 2){
            setTypeInAPI("food")
        }
        else if(sender.tag == 3){
            setTypeInAPI("cafe")
        }
        else if(sender.tag == 4){
            setTypeInAPI("night_club")
        }
        else if(sender.tag == 5){
            setTypeInAPI("taxi_stand")
        }
    }

    
    // MARK : Map View Delegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let identifier = "MapAnnotationGoogleApi"
        
        if annotation.isKindOfClass(MapAnnotationGoogleApi.self) {
            
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView
                
            }
            else {
                
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
            }
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
        
        let annotationDetail = view.annotation as! MapAnnotationGoogleApi
        let placeName = annotationDetail.name
        let placeAddress = annotationDetail.address
        
        let ac = UIAlertController(title: placeName, message: placeAddress, preferredStyle: .Alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func navigateBtn(sender: AnyObject) {
        
        let googleApi = self.storyboard?.instantiateViewControllerWithIdentifier("loginPage") as! URLSessionUploadTaskWithParameters
        self.navigationController?.pushViewController(googleApi, animated: true)
        
    }
    
    
    
}
