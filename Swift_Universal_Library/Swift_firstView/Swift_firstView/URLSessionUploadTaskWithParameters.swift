//
//  URLSessionUploadTaskWithParameters.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 22/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class URLSessionUploadTaskWithParameters: UIViewController, NSURLSessionDelegate,
NSURLSessionDataDelegate, UITextFieldDelegate {
    
    var session : NSURLSession!
    
    var mutableData : NSMutableData = NSMutableData()
    
    var task : NSURLSessionDataTask!
    
    var jsonObj : Json_Object!
    
    var myObjArr = [Json_Object]()
    
    var jsonDictionary = NSDictionary()
    
    var jsonDataDictionary = NSDictionary()
    
    var email : String!
    
    var country : String!
    
    var imageUrl : String!
    
    var loginObject : LoginDataObject!
    
    var loginDataArray : NSMutableArray!
    
    var dataJson : NSData!

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
              // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Submit Button.
    
    @IBAction func submitClicked(sender: AnyObject) {
        
        let urlString1 : String = "http://www.cgtechnosoft.net/delivit/api/login"
        
        let singletonObject = SingletonNSUrlSession.sharedInstance
        
        let user : NSString = self.emailTextField.text!

        let pass: NSString = self.passwordTextField.text!
        
        let device_id : NSString = "1"
        
        let socialLog : NSString = "0"
        
        let paramDictionary = ["email":(user as String), "password" : (pass as String), "device_id" : (device_id as String), "device_type" : (device_id as String), "social_login" : (socialLog as String)]
        
        self.jsonDictionary = singletonObject.urlWithJsonAndParameters(paramDictionary, urlString: urlString1)
        
        print("Dictionary is", self.jsonDictionary)
        
        
            
                 if let dictionary = self.jsonDictionary as? [String: AnyObject]{
                    
                    let errorCode : NSNumber = dictionary["error"]! as AnyObject as! NSNumber
            
                    if(errorCode == 0){
                            print("+++++++++ Login Successful +++++++++")
                            self.parseJsonAndNavigate()
            
                    }else{
                            print("--------- Login Un-Successful ---------------")
                    }
                }
      
    }

    
    // MARK: - ParseJson and Navigate:

    
    func parseJsonAndNavigate(){
    
          self.loginObject = LoginDataObject()
        
          self.loginDataArray = NSMutableArray()
        
            if let dictionary = self.jsonDictionary as? [String: AnyObject]{
                
                self.email = (dictionary["data"]?["email"]!)!as AnyObject as! String
            
                self.country = (dictionary["data"]?["country"]!)!as AnyObject as! String
            
                self.imageUrl = (dictionary["data"]?["photo"]!)!as AnyObject as! String
            
                //print("email is", self.email)
                self.loginObject.email = self.email
                
                self.loginObject.country = self.country
                
                self.loginObject.imageUrl = self.imageUrl
            
                print("email is", self.loginObject.email)
                self.loginDataArray.addObject(self.loginObject)
            
                print("count is",self.loginDataArray.count)
                
                print("count in urlSessionUpload", self.loginDataArray.count)
            
            }
        
            // navigate between controllers.
        
                var fetch = FetchedDataAfterLogin()
        
                fetch = self.storyboard?.instantiateViewControllerWithIdentifier("ShowData") as! FetchedDataAfterLogin
        
                fetch.fetchData = self.loginDataArray
        
                print("count login Arr", self.loginDataArray.count)
        
                print("fetch Data arr", fetch.fetchData.count)
        
                dispatch_async(dispatch_get_main_queue(), {
                    
                //Code that presents or dismisses a view controller here
                    
                    self.navigationController?.pushViewController(fetch, animated: true)
                    
            })
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}

//extension NSMutableData {
//    
//    func appendString(string: String) {
//        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//        appendData(data!)
//    }
//}
//
