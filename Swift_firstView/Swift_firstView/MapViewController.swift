//
//  MapViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 01/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{

//    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var mapView: MKMapView!
   
    @IBOutlet var mapView1: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapView1.delegate=self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Navigate", style: .Plain, target: self, action: "performAdd:")
    }
    
    
    func performAdd(sender:UIBarButtonItem){
        
        let downJson = self.storyboard?.instantiateViewControllerWithIdentifier("downloadJsonData") as! DownloadJsonData
        self.navigationController?.pushViewController(downJson, animated: true)
        
    }
    
    /* Add the pin to the map and center the map around the pin */
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addPinToMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView1 = MKMapView()
    }
    
    
    /* We have a pin on the map; now zoom into it and make that pin the center of the map */
    
    func setCenterOfMapToLocation(location:CLLocationCoordinate2D){
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView1.setRegion(region, animated: true)
    }
    
    
    /* These are just sample locations */
//    let purpleLocation = CLLocationCoordinate2D(latitude: 58.592737, longitude: 16.185898)
//    let blueLocation = CLLocationCoordinate2D(latitude: 58.593038, longitude: 16.188129)
    
    func addPinToMapView(){
    
        let purpleLocation = CLLocationCoordinate2D(latitude: 58.592737, longitude: 16.185898)
        let blueLocation = CLLocationCoordinate2D(latitude: 58.593038, longitude: 16.188129)
        let redLocation = CLLocationCoordinate2D(latitude: 58.591831, longitude: 16.189073)
        let greenLocation = CLLocationCoordinate2D(latitude: 58.590522, longitude: 16.185726)
    
        let purpleAnnotation = MyAnnotationCustom(coordinate: purpleLocation, title: "Purple", subtitle: "My Purple", pincolor: .Purple)
    
        let blueAnnotation = MyAnnotationCustom(coordinate: blueLocation, title: "Blue", subtitle: "My Blue", pincolor: .Blue)
    
        let redAnnotation = MyAnnotationCustom(coordinate: redLocation, title: "Red", subtitle: "My Red", pincolor: .Red)
    
        let greenAnnotation = MyAnnotationCustom(coordinate: greenLocation, title: "Green", subtitle: "My Green", pincolor: .Green)
    
        /* And eventually add them to the map */
        mapView1.addAnnotations([purpleAnnotation, blueAnnotation, redAnnotation, greenAnnotation])
    
        /* And now center the map around the point */
        setCenterOfMapToLocation(purpleLocation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
    
        if annotation is MyAnnotationCustom == false{
            return nil
        }
        /* First, typecast the annotation for which the Map View fired this delegate message */
        let senderAnnotation = annotation as! MyAnnotationCustom
        /* We will attempt to get a reusable
        identifier for the pin we are about to create */
        let pinReusableIdentifier = senderAnnotation.pinColor.rawValue
        /* Using the identifier we retrieved above, we will attempt to reuse a pin in the sender Map View */
        var annotationView = mapView1.dequeueReusableAnnotationViewWithIdentifier( pinReusableIdentifier ) as? MKPinAnnotationView
        
        if annotationView == nil{
       
            /* If we fail to reuse a pin, we will create one */
            annotationView = MKPinAnnotationView(annotation: senderAnnotation, reuseIdentifier: pinReusableIdentifier)
            /* Make sure we can see the callouts on top of each pin in case we have assigned title and/or subtitle to each pin */
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
    
    
//    let reuseId = "test"
//    
//    var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
//    if anView == nil {
//    anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//    anView.canShowCallout = true
//    }
//    else {
//    anView.annotation = annotation
//    }
//    
//    //Set annotation-specific properties **AFTER**
//    //the view is dequeued or created...
//    
//    let cpa = annotation as CustomPointAnnotation
//    anView.image = UIImage(named:cpa.imageName)

}

//    func addPinToMapView(){
//
//        /* This is just a sample location */
//        let location = CLLocationCoordinate2D(latitude: 19.0176147, longitude: 72.8561644)
//        
//        
//        /* Create the annotation using the location */
//        let annotation = MyMapAnnotation(coordinate: location, title: "My Title", subTitle: "MySubTitle")
//    
//        /* And eventually add it to the map */
//        mapView.addAnnotation(annotation)
//        
//        /* And now center the map around the point */
//       // setCenterOfMapToLocation(location)
//    }

