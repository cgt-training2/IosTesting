//
//  Meal1.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 30/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class Meal1 : NSObject, NSCoding{

    // MARK: Properties
    
//    You mark these constants with the static keyword, which means they apply to the class instead of an instance of the class. Outside of the Meal class, you’ll access the path using the syntax Meal.ArchiveURL.path!.
    
     static let documentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let archiveURL = documentDirectory.URLByAppendingPathComponent("meals")
    
    
    // MARK: Types
    
    struct propertyKey {

        static let namekey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }

    
    // MARK Coder
    
    func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(name, forKey: propertyKey.namekey)
            aCoder.encodeObject(photo, forKey: propertyKey.photoKey)
            aCoder.encodeObject(rating, forKey: propertyKey.ratingKey)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//    }

    
    // Here, you’re declaring this initializer as a convenience initializer because it only applies when there’s saved data to be loaded.
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
    
        let name1 = aDecoder.decodeObjectForKey(propertyKey.namekey) as! String
        
         // Because photo is an optional property of Meal, use conditional cast.
        let photo1 = aDecoder.decodeObjectForKey(propertyKey.photoKey) as? UIImage
        
        let rating1 = aDecoder.decodeIntegerForKey(propertyKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name1, photo: photo1, rating:rating1)
        
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}