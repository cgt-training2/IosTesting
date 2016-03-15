//
//  FetchedDataAfterLogin.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 25/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit


class FetchedDataAfterLogin : UIViewController {

    @IBOutlet var downloadedImage: UIImageView!
    
    var fetchData : NSMutableArray!
    
    var loginObject : LoginDataObject!
    
    @IBOutlet var downEmailLabel: UILabel!
    
    var email : String!
    
    var country : String!
    
    @IBOutlet var downCountryLabel: UILabel!
    
    var imageUrl : String!
    
    // download Image:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read array from NSUserDefaults.
        
//      if let testArray : AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("loginArr") {
//                let readArray : [LoginDataObject] = testArray! as! [LoginDataObject]
//                print(readArray)
//            }
        
        print("after Login", self.fetchData.count)
        
        for data in fetchData{
            
            self.loginObject = LoginDataObject()
            
            self.loginObject = data as! LoginDataObject
            
            self.email = self.loginObject.email
            self.country = self.loginObject.country
            self.imageUrl = self.loginObject.imageUrl
            
            print(self.imageUrl)
            
            dispatch_async(dispatch_get_main_queue(), {
                // code here
                
                self.downloadImage()
            })
        }
        
        // Do any additional setup after loading the view.
        
         navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigateAction:")
    
    }

    func downloadImage(){
        
        let url = NSURL(string: self.imageUrl)
        let conf: NSURLSessionConfiguration = NSURLSession.sharedSession().configuration
        let session = NSURLSession(configuration: conf)
        
        HUD.show(.Progress)
        
        // Now some long running task starts...
        
        let task = session.downloadTaskWithURL(url!) { (location, response, error) -> Void in
            
            let image1 : UIImage = UIImage(data: NSData(contentsOfURL: location!)!)!

            self.downloadedImage.image = image1
            self.downEmailLabel.text = self.email
            self.downCountryLabel.text = self.country
            
            self.delay(3.0) {
               // ...and once it finishes we flash the HUD for a second.
                HUD.flash(.Success, withDelay: 0.5)
            }
        }
        
        task.resume()
    }
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigateAction(sender: AnyObject) {
        
       // var rentCar = RentCarAPIData_Table()
        
       let  rentCar = self.storyboard?.instantiateViewControllerWithIdentifier("rentCar") as! RentCarAPIData_Table
        
        self.navigationController?.pushViewController(rentCar, animated: true)
        
    }
   
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
