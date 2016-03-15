//
//  RegisterViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 09/03/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, NSURLSessionDelegate {

    @IBOutlet var scrollRegister: UIScrollView!
    
    @IBOutlet var fNameTextField: UITextField!
    
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var genderTxtField: UITextField!
    
    @IBOutlet var devIdTxtField: UITextField!
    
    @IBOutlet var passTxtField: UITextField!
    
    @IBOutlet var uNameTxtField: UITextField!
    
    @IBOutlet var countryTxtField: UITextField!
    
    @IBOutlet var eMailTxtField: UITextField!
    
    @IBOutlet var lNameTxtField: UITextField!
    
    var session: NSURLSession!

    // API Link: http://www.cgtechnosoft.net/delivit/api/register
    
    // PARAMETERS: first_name,last_name,email,country,gender,username,password,device_id,photo
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        /* Create our configuration first */
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 15.0
        
        /* Now create our session which will allow us to create the tasks */
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
    }
    
    
    // The output below is limited by 1 KB.
    // Please Sign Up (Free!) to remove this limitation.
    
    // The output below is limited by 1 KB.
    // Please Sign Up (Free!) to remove this limitation.
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    func myImageUploadRequest()
    {
        let myUrl = NSURL(string: "http://www.cgtechnosoft.net/delivit/api/register/");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
//        let param = [
//            "firstName"  : "Sergey",
//            "lastName"    : "Kargopolov",
//            "userId"    : "9"
//        ]

        
        
//        , "photo" : ""
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(imgProfile.image!, 1)
        
        let param = ["first_name" : fNameTextField.text!,"last_name" : lNameTxtField.text!, "email" : eMailTxtField.text!, "country" : countryTxtField.text!, "gender" : genderTxtField.text!, "username" : uNameTxtField.text!, "password" : passTxtField.text!, "device_id" : devIdTxtField.text!]
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "photo", imageDataKey: imageData!, boundary: boundary)
        
        
        
      //  myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
         //   var err: NSError?
            do{
                var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
            }
            catch{
                print("error is",error)
            }
            
            
            dispatch_async(dispatch_get_main_queue(),{
                //self.myActivityIndicator.stopAnimating()
              //  self.myImageView.image = nil;
            });
            
            /*
            if let parseJSON = json {
            var firstNameValue = parseJSON["firstName"] as? String
            println("firstNameValue: \(firstNameValue)")
            }
            */
            
        }
        
        task.resume()
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
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
    
    @IBAction func submitClicked(sender: AnyObject) {
        self.myImageUploadRequest()
    }

}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

//    func uploadData(){
//        
//        print("Button Clicked")
//        let url = NSURL(string: "http://www.cgtechnosoft.net/delivit/api/register")
//        
//        let request : NSMutableURLRequest = NSMutableURLRequest(URL:url!)
//        
////        let boundary = generateBoundaryString()
//        
//        request.HTTPMethod = "POST"
//        
//        let image1 : UIImage = imgProfile.image!
//        
//       // let imageData : NSData! = UIImagePNGRepresentation(image1)
//        let imageData : NSData! = UIImageJPEGRepresentation(image1, 0.5)
//        
//        let dictionary : NSMutableDictionary = ["first_name" : fNameTextField.text!,"last_name" : lNameTxtField.text!, "email" : eMailTxtField.text!, "country" : countryTxtField.text!, "gender" : genderTxtField.text!, "username" : uNameTxtField.text!, "password" : passTxtField.text!, "device_id" : devIdTxtField.text!, "photo" : ""]
//        
//        do{
//            
//            let dataToUpload : NSData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
//            //            let uploadTask : NSURLSessionUploadTask = session.uploadTaskWithRequest(request, fromData: dataToUpload)
//
//            //            uploadTask.resume()
//            
//            let uploadTask : NSURLSessionUploadTask = session.uploadTaskWithRequest(request, fromData: dataToUpload, completionHandler:{
//                    data, response, error in
//                    do{
//                          let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!,                                 options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                        
//                               if let dictionary = jsonDictionary as? [String: AnyObject]{
//                                    print("inside Upload Task")
//                                    print("dictionary",dictionary)
//                               }
//                        
//                    }catch{
//                        print(error)
//                    }
//                }
//                )
//            uploadTask.resume()
//        }
//        catch{
//            print(error)
//        }
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


