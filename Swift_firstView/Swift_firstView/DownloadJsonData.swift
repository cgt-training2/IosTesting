//
//  DownloadJsonData.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 05/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

//extension NSURLSessionDataTask{
//    func start(){
//        self.resume()
//    }

//}

class DownloadJsonData: UIViewController, NSURLSessionDelegate, NSURLSessionDataDelegate, MKMapViewDelegate {
    
    var session : NSURLSession!
    
    //var dataString : NSString!
    /* We will download a URL one chunk at a time and append the downloaded data to this mutable data */
    
    @IBOutlet var mapViewJson: MKMapView!
    
    var latitude : Double!
    var longitude : Double!
    var counter : Int!
    var locationArray = [CLLocationCoordinate2D]?()
    
    var locationArray1 = [CLLocation]()
    //let latitude:Float;()
    
    var mutableData : NSMutableData = NSMutableData()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* Create our configuration first */
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 15.0
        // initialize a array
     
//        var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        mapViewJson = MKMapView()
        /* Now create a session that allows us to create the tasks */
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Now attempt to download the contents of the URL */
        
          navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigateBtn:")
        
       let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=51.405852,-0.010691&radius=500&types=bar&sensor=true&key=AIzaSyASrAXTeqLCU5TJo1pJLjTYJnhISU2ZPPg")
        
        self.mapViewJson.delegate = self
//        let task = session.dataTaskWithURL(url!, completionHandler: {
//        
//                [weak self] (data: NSData?,response: NSURLResponse?, error: NSError?) in
//        
//                /* We got our data here */
//               // print("data is",data)
//                self!.session.finishTasksAndInvalidate()
//            })
           let task = session.dataTaskWithURL(url!)
        task.resume()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    /* We have a pin on the map; now zoom into it and make that pin the center of the map */
    
    func setCenterOfMapToLocation(location:CLLocationCoordinate2D){
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapViewJson.setRegion(region, animated: true)
   }
    
    
    /* These are just sample locations */
    //    let purpleLocation = CLLocationCoordinate2D(latitude: 58.592737, longitude: 16.185898)
    //    let blueLocation = CLLocationCoordinate2D(latitude: 58.593038, longitude: 16.188129)
    
    func addPinToMapView1(locationArr:[CLLocation]){
        
        let latitude = locationArr[0].coordinate.latitude
        let longitude = locationArr[0].coordinate.longitude
        
        let latitude1 = locationArr[1].coordinate.latitude
        let longitude1 = locationArr[1].coordinate.longitude

        let purpleLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let greenLocation = CLLocationCoordinate2D(latitude: latitude1, longitude: longitude1)
        
        
        let purpleAnnotation = MyAnnotationCustom(coordinate: purpleLocation, title: "Main", subtitle: "Main Sub", pincolor: .Purple)
        
        let greenAnnotation = MyAnnotationCustom(coordinate: greenLocation, title: "Second", subtitle: "Second Sub", pincolor: .Green)

        mapViewJson.addAnnotations([purpleAnnotation, greenAnnotation])
        
        setCenterOfMapToLocation(purpleLocation)
        
    }
    
    func addPinToMapView(lati : Double , longi : Double){
        
//        let purpleLocation = CLLocationCoordinate2D(latitude: lati, longitude: longi)
//        
//        let purpleAnnotation = MyAnnotationCustom(coordinate: purpleLocation, title: "Purple", subtitle: "My Purple", pincolor: .Purple)
//        
//        /* And eventually add them to the map */
//        mapViewJson.addAnnotations([purpleAnnotation,])
//        
//        /* And now center the map around the point */
//        setCenterOfMapToLocation(purpleLocation)
    }
    
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title: String, message: String){
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    // MARK :: MapView Delegates.
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MyAnnotationCustom == false{
            return nil
        }
        
        /* First, typecast the annotation for which the Map View fired this delegate message */
        
        let senderAnnotation = annotation as! MyAnnotationCustom
        
        /* We will attempt to get a reusable
        identifier for the pin we are about to create */
        let pinReusableIdentifier = senderAnnotation.pinColor.rawValue
        
        /* Using the identifier we retrieved above, we will attempt to reuse a pin in the sender Map View */
        var annotationView = mapViewJson.dequeueReusableAnnotationViewWithIdentifier( pinReusableIdentifier ) as? MKPinAnnotationView
        
        if annotationView == nil{
        
            /* If we fail to reuse a pin, we will create one */
            annotationView = MKPinAnnotationView(annotation: senderAnnotation, reuseIdentifier: pinReusableIdentifier)
            //            /* Make sure we can see the callouts on top of each pin in case we have assigned title and/or subtitle to each pin */
            
           annotationView!.canShowCallout = true
            
        }
        
        if senderAnnotation.pinColor == .Blue {
        
            let pinImage = UIImage(named:"pinImage")
                    annotationView!.image = pinImage
        
       } else {
            annotationView!.pinColor = senderAnnotation.pinColor.toPinColor()
       }
       
        return annotationView
    }
    
    
    //MARK: Session Delegate.
    
    // To parse nested JSON Latitude and longitude.
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
              
        data.enumerateByteRangesUsingBlock{
            [weak self] (pointer: UnsafePointer<()>, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
        
                let newData = NSData(bytes: pointer, length: range.length)
        
                self!.mutableData.appendData(newData)
        }
        
        
        let dataString = NSString(data: self.mutableData, encoding : NSUTF8StringEncoding)
 
        
        let dataJson = dataString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        
      //  var i :Int=0
        
     //   i=0
        do{
            
            let jsonString = try NSJSONSerialization.JSONObjectWithData(dataJson!, options: NSJSONReadingOptions.MutableContainers)
 
            if let dictionary = jsonString as? [String: AnyObject]{
              
                if let results = dictionary["results"] as? [AnyObject]{
                   
                    for dictionary2 in results {
                    
                        //place_id, reference, scope
                        latitude = dictionary2["geometry"]?!["location"]?!["lat"]! as? Double
                        longitude = dictionary2["geometry"]?!["location"]?!["lng"]! as? Double

//                        let locationCoordinate = CLLocation(latitude: latitude, longitude: longitude)
//                       
//                        locationArray1.append(locationCoordinate)
                       
                        print("location Array",locationArray)
                        print("Latitude is", latitude)
                        print("longitude is", longitude)
                        
                        //i=i+1
                    }
                }
            }
           // addPinToMapView1(locationArray1)
        }
        catch{
            print(error)
        }
        
    }
    
    
    // To parse the json from the internet.
    
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        
//        //print(" **********Session Delegate ************* ")
//        data.enumerateByteRangesUsingBlock{
//            [weak self] (pointer: UnsafePointer<()>, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
//            
//            let newData = NSData(bytes: pointer, length: range.length)
//            
//            self!.mutableData.appendData(newData)
//        }
//        
//        
//        let dataString = NSString(data: self.mutableData, encoding : NSUTF8StringEncoding)
//        // print("******* Site Data is******/n", dataString)
//        
//        let dataJson = dataString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
//        
//        do{
//            
//            let jsonString = try NSJSONSerialization.JSONObjectWithData(dataJson!, options: NSJSONReadingOptions.MutableContainers)
//            // print("json String is", jsonString)
//            if let dictionary = jsonString as? [String: AnyObject]{
//
//                if let results = dictionary["results"] as? [AnyObject]{
//                    
//                    
//                    // geometry, location, ( lat, lng )
//                    // print("result string is", results)
//                    for dictionary2 in results {
//                        
//                        //place_id, reference, scope
//                        let place_id = dictionary2["place_id"] as? String
//                        let reference = dictionary2["reference"] as? String
//                        let scope = dictionary2["scope"] as? String
//                        print("Latitude is", place_id)
//                        print("longitude is", reference)
//                        print("location1 is", scope)
//                    }
//                    
//                }
//                
//            }
//        }
//        catch{
//            print(error)
//        }
//        
//    }

    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
      
        /* Now you have your data in the mutableData property */
        
        session.finishTasksAndInvalidate()
        dispatch_async(dispatch_get_main_queue(), {[weak self] in
                var message = "Finished downloading your content"
            if error != nil{
                    message = "Failed to download your content"
                }
                self!.displayAlertWithTitle("Done", message: message)
            })
    }
    
    
    @IBAction func navigateBtn(sender: AnyObject) {
       let googleApi = self.storyboard?.instantiateViewControllerWithIdentifier("googleAPIMap") as! GoogleAPIMapViewControllerWithButtonTag
        self.navigationController?.pushViewController(googleApi, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
