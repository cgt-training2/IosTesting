//
//  MapAnnotationGoogleApi.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 13/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotationGoogleApi: NSObject, MKAnnotation {
    
//    var coordinate = CLLocationCoordinate2DMake( 19.0176147, 72.8561644 )
    var coordinate : CLLocationCoordinate2D
    var name: String?
    var address : String?
    var title : String?
    var subTitle:String?
    
    init(coordinate : CLLocationCoordinate2D, name: String, address: String) {
        self.coordinate = coordinate
        self.name = name
        self.address = address
        self.title = name
        self.address = address
        super.init()
    }
}
