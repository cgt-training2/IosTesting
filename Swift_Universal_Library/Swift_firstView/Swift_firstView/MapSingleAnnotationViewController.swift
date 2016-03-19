//
//  MapSingleAnnotationViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 05/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit
class MapSingleAnnotationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate=self
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigate:")
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }


    func navigate(sender:UIBarButtonItem){
        
        let mapViewController = self.storyboard?.instantiateViewControllerWithIdentifier("mapMultiAnnotation") as! MapViewController
        self.navigationController?.pushViewController(mapViewController, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addPinToMapView()
    }
    
    func addPinToMapView(){
        
        /* This is just a sample location */
        
        let location = CLLocationCoordinate2D(latitude: 58.592737 , longitude: 16.185898)
        
        /* Create the annotation using the location */
        
        let annotation = MyMapAnnotation(coordinate: location, title: "My Title", subTitle: "My Sub Title")
        
         /* And eventually add it to the map */
        
        mapView.addAnnotation(annotation)
        
        /* And now center the map around the point */
        
        setCenterOfMap(location)
    
    }
    
//    func addPinToMapView(){
//        /* This is just a sample location */
//        let location = CLLocationCoordinate2D(latitude: 58.592737, longitude: 16.185898)
//        /* Create the annotation using the location */
//        let annotation = MyAnnotation(coordinate: location, title: "My Title",
//        subtitle: "My Sub Title")
//        /* And eventually add it to the map */
//        mapView.addAnnotation(annotation)
//        /* And now center the map around the point */
//        setCenterOfMapToLocation(location)
//    }
//    
    /* We have a pin on the map; now zoom into it and make that pin the center of the map */
    
    func setCenterOfMap(location: CLLocationCoordinate2D){
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
