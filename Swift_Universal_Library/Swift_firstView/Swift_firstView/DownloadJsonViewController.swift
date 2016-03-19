//
//  DownloadJsonViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 04/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class DownloadJsonViewController: UIViewController, NSURLSessionDelegate {

    var session: NSURLSession!
    
    required init?(coder aDecoder: NSCoder) {
        
            super.init(coder: aDecoder)
        
            /* Create our configuration first */
        
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
            configuration.timeoutIntervalForRequest = 15.0
    
            /* Now create our session which will allow us to create the tasks */
    
            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
    }

    /* Identifier :::  "downloadJsonData" */
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* Now attempt to download the contents of the URL */
        
         navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigate:")
        
            let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=51.405852,-0.010691&radius=500&types=bar&sensor=true&key=AIzaSyASrAXTeqLCU5TJo1pJLjTYJnhISU2ZPPg")
            let task = session.dataTaskWithURL(url!, completionHandler: {
        
        [weak self] (data: NSData?,response: NSURLResponse?, error: NSError?) in
        
                /* We got our data here */
                
              //  let dataString = NSString(data: data!, encoding:NSUTF8StringEncoding)
                
               // print("data is",dataString)
                self!.session.finishTasksAndInvalidate()
        
        })
            task.resume()
    }

    
    func navigate(sender:UIBarButtonItem){
        
        let downloadJson = self.storyboard?.instantiateViewControllerWithIdentifier("downloadJsonData") as! DownloadJsonData
        self.navigationController?.pushViewController(downloadJson, animated: true)
        
    }
    
}

    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

