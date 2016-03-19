//
//  SingletonNSUrlSession.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 18/03/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class SingletonNSUrlSession : NSObject, NSURLSessionDelegate {
    
    var session: NSURLSession!
    
    var propertyDictionary : NSDictionary!
    
    var jsonData : NSData!
    
    static let sharedInstance: SingletonNSUrlSession = SingletonNSUrlSession()
    
    
    func myImageUploadRequest(urlStr: String?,param: [String: String]?, filePath: String?, imageData: NSData) -> NSDictionary
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
                configuration.timeoutIntervalForRequest = 15.0
        
                /* Now create our session which will allow us to create the tasks */
        
                session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let myUrl = NSURL(string: urlStr!)
      
        let request = NSMutableURLRequest(URL:myUrl!)
        
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var json = NSMutableDictionary()
        request.HTTPBody = self.createBodyWithParameters(param, filePathKey: filePath, imageDataKey: imageData, boundary: boundary)
        
        json = dataTask1(request)
        
        return json
        
    }
    
    func dataTask1(request : NSMutableURLRequest)->NSMutableDictionary{
        
        var json = NSMutableDictionary()
        
        var statusCode = -1
        
        let group = dispatch_group_create()
        
        dispatch_group_enter(group)
        
        session.dataTaskWithRequest(request, completionHandler:
        {
                (responseData, response, error) -> Void in
                
                    if let httpResponse = response as? NSHTTPURLResponse {
                        statusCode = httpResponse.statusCode
                        self.jsonData = responseData
                    }
                dispatch_group_leave(group)
                
        }).resume()
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        
        if statusCode == 403 {

        }
            
        else if (statusCode >= 200 && statusCode < 400 )
        {
            
            do{
                  json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! NSMutableDictionary
                  print("Dictionary1555 is:",json)
                
               }
               catch{
                
                   print("error is",error)
                
               }
            
        }
        
        return json
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpeg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
   func urlWithJsonAndParameters(paramDictionary: [String: String]?, urlString : String?)-> NSDictionary{
    
        var dataJson : NSData!
    
        var statusCode = -1
    
        var jsonDictionary : NSDictionary!
    
        let url = NSURL(string: urlString!)
    
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:url!)
    
        request.HTTPMethod = "POST"
    
        do{
            dataJson = try NSJSONSerialization.dataWithJSONObject(paramDictionary!, options: .PrettyPrinted)
        }
        catch{
            print(error)
        }
    
    
        request.HTTPBody = dataJson
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    
        let conf: NSURLSessionConfiguration = NSURLSession.sharedSession().configuration
    
        let session = NSURLSession(configuration: conf)
    
        let group = dispatch_group_create()
    
        dispatch_group_enter(group)
    
        session.dataTaskWithRequest(request, completionHandler: {
            
            (responseData, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
            statusCode = httpResponse.statusCode
                
            self.jsonData = responseData
                
            }
                dispatch_group_leave(group)
            
            }).resume()
    
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
    
        if statusCode == 403 {
        
        }
        
        else if (statusCode >= 200 && statusCode < 400 )
        {
        
            do{
                jsonDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! NSMutableDictionary
                print("Dictionary1555 is:",jsonDictionary)
            
            }
            catch{
                print("error is",error)
            }
        
        }
    
        return jsonDictionary
    }

}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
