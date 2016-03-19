//
//  MyAnnotationCustom.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 02/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit
import MapKit

/* This allows us to check for equality between two items of type PinColor */
func == (left:PinColor, right:PinColor) -> Bool{
    return left.rawValue==right.rawValue
}


enum PinColor:String{
    
    case Blue = "Blue"
    case Red = "Red"
    case Green = "Green"
    case Purple = "Purple"
 
    
    func toPinColor() -> MKPinAnnotationColor{
        
        switch self{
            
        case .Red:
            
             return .Red
            
        case .Green:
            
             return .Green
            
        case .Purple:
            
             return .Purple
        
        default:
            
             return .Red
            
        }
    }
}

class MyAnnotationCustom: NSObject, MKAnnotation {
   
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title : String?
    var subTitle : String!
    var pinColor : PinColor!
    
    init(coordinate: CLLocationCoordinate2D, title:String, subtitle:String, pincolor:PinColor){
        
        self.coordinate = coordinate
        self.title = title
        self.subTitle = subtitle
        self.pinColor = pincolor
        
        super.init()
    }
    
    convenience init(coordinate:CLLocationCoordinate2D, title: String, subtitle: String){
        self.init(coordinate : coordinate, title : title, subtitle : subtitle, pincolor: .Blue)
    }
}
