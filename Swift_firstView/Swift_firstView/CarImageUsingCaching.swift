//
//  CarImageUsingCaching.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 09/03/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class CarImageUsingCaching: UITableViewController,  NSURLSessionDelegate {

    @IBOutlet var rentTableLibrary: UITableView!
    
    var myArray4Object : NSMutableArray!
    var session: NSURLSession!
    var rentCarObj : RentCarObjectClass!
    var imgDataArr : NSMutableArray!
    var i: Int = 0
    var rowCount: Int = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* Create our configuration first */
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 15.0
        
        /* Now create our session which will allow us to create the tasks */
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    func downloadData(){
        
        //  let url = NSURL(string: "http://poice.net/rent2ride/cars/rent_a_car")
        
        let url = NSURL(string: "http://cgtechnosoft.net/rent2ride/cars/rent_a_car")
        
        var paramString = ""
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:url!)
        
        request.HTTPMethod = "POST"
        
        // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user : NSString = "15.000000"
        
        let pass: NSString = "26.2800113"
        
        let device_id : NSString = "73.0020112"
        
        let socialLog : NSString = "19800"
        
        let social : NSString = "154"
        
        paramString = "distance="+(user as String)+"&lat="+(pass as String)
        
        let strParam = "&long="+(device_id as String)+"&time_difference="+(socialLog as String)+"&userid="+(social as String)
        
        paramString = paramString + strParam
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        session.dataTaskWithRequest(request) {
            data, response, error in
            
            do{
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                if let dictionary = jsonDictionary as? [String: AnyObject]{
                    
                    print("dictionary",dictionary)
                    self.parseDictionary(dictionary)
                }
            }
            catch{
                print(error)
            }
            }.resume()
    }
    
    
    // MARK: - parseDictionary()
    
    func parseDictionary(dict: NSDictionary){
        
        myArray4Object = NSMutableArray()
        
        if let results = dict["Data"] as? [AnyObject]{
            
            for dict1 in results{
                
                rentCarObj = RentCarObjectClass()
                
                rentCarObj.carId = dict1["carid"] as? String
                rentCarObj.carName = dict1["car_name"] as? String
                rentCarObj.image = dict1["image"] as? String
                
                //               if((rentCarObj.image) != nil){
                
                myArray4Object.addObject(rentCarObj)
                //                }
            }
        }
        
        rowCount = myArray4Object.count
        //print("My Array Value ::",myArray4Object.count)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.rentTableLibrary.reloadData()
        })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("rentLibraryCell", forIndexPath: indexPath) as! RentCarApi_TableCell
        
        self.rentCarObj = RentCarObjectClass()
        
        self.rentCarObj = myArray4Object.objectAtIndex(indexPath.row) as! RentCarObjectClass
        
        cell.carIdLabel.text = self.rentCarObj.carId as? String
        cell.carNameLabel.text = self.rentCarObj.carName as? String
        
        // Configure the cell...
        let imgUrlStr : String = self.rentCarObj.image as! String
        
        // let imgUrlStr : String = self.myArr.objectAtIndex(indexPath.row) as! String
        
        cell.carImage.kf_setImageWithURL(NSURL(string: imgUrlStr)!)
        
        return cell
    }
   

    /*
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    [request setHTTPMethod:@"GET"];
    
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if (cachedResponse.data) {
    UIImage *downloadedImage = [UIImage imageWithData:cachedResponse.data];
    dispatch_async(dispatch_get_main_queue(), ^{
    cell.thumbnailImageView.image = downloadedImage;
    });
    } else {
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (!error) {
    UIImage *downloadedImage = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
    cell.thumbnailImageView.image = downloadedImage;
    });
    }
    }];
    [dataTask resume];
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
