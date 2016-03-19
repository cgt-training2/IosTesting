//
//  MyMapAnnotation.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 02/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

class MyMapAnnotation: NSObject, MKAnnotation{

    var coordinate = CLLocationCoordinate2DMake( 19.0176147, 72.8561644 )
    var title : String?
    var subTitle:String?
    
    init(coordinate : CLLocationCoordinate2D, title: String, subTitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subTitle = subTitle
        super.init()
    }
    
//    func mapView(mapView: MKMapView!,
//        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
//    
//    }
}
