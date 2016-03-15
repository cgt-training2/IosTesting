//
//  URLSessionUploadTaskWithParameters.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 22/02/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class URLSessionUploadTaskWithParameters: UIViewController, NSURLSessionDelegate, NSURLSessionDataDelegate, UITextFieldDelegate {
    
    
    var session : NSURLSession!
    
    var mutableData : NSMutableData = NSMutableData()
    
    var task : NSURLSessionDataTask!
    
    var jsonObj : Json_Object!
    
    var myObjArr=[Json_Object]()
    
    var jsonDictionary : NSDictionary!
    
    var jsonDataDictionary = NSDictionary()
    
    var email : String!
    
    var country : String!
    
    var imageUrl : String!
    
    var loginObject : LoginDataObject!
    
    var loginDataArray : NSMutableArray!

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
        
        let url = NSURL(string: "http://www.cgtechnosoft.net/delivit/api/login")
        
            var paramString = ""
        
            let request:NSMutableURLRequest = NSMutableURLRequest(URL:url!)
        
            request.HTTPMethod = "POST"
        
        self.loginDataArray = NSMutableArray()
        
        let user : NSString = self.emailTextField.text!
        
        let pass: NSString = self.passwordTextField.text!
        
        let device_id : NSString = "1"
        
        let socialLog : NSString = "0"
        
        paramString = "email="+(user as String)+"&password="+(pass as String)
       
        let strParam = "&device_id="+(device_id as String)+"&device_type="+(device_id as String)+"&social_login="+(socialLog as String)
        
        paramString = paramString + strParam
        
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let conf: NSURLSessionConfiguration = NSURLSession.sharedSession().configuration
        
        let session = NSURLSession(configuration: conf)
        
        session.dataTaskWithRequest(request) {
        
            data, response, error in
                
                do{
                    self.jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    self.loginObject = LoginDataObject()
                    if let dictionary = self.jsonDictionary as? [String: AnyObject]{
                        
//                      let errorCode : String = dictionary["message"]! as AnyObject as! String
                        let errorCode : NSNumber = dictionary["error"]! as AnyObject as! NSNumber
                        
                        if(errorCode == 0){
                            print("+++++++++ Login Successful +++++++++")
                            self.parseJsonAndNavigate()

                        }else{
                                print("--------- Login Un-Successful ---------------")
                        }
                    }
                }
                catch{
                    print(error)
                }
                
//                let resp = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("String is", resp)
                
            }.resume()
    }

    
    // MARK: - ParseJson and Navigate

    
    func parseJsonAndNavigate(){
    
            if let dictionary = self.jsonDictionary as? [String: AnyObject]{
                
                //  let errorCode : String = dictionary["message"]! as AnyObject as! String
            
                //  self.jsonDataDictionary = dictionary["data"] as! NSDictionary
            
                self.email = (dictionary["data"]?["email"]!)!as AnyObject as! String
            
                self.country = (dictionary["data"]?["country"]!)!as AnyObject as! String
            
                self.imageUrl = (dictionary["data"]?["photo"]!)!as AnyObject as! String
            
                self.loginObject.email = self.email
                self.loginObject.country = self.country
                self.loginObject.imageUrl = self.imageUrl
            
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
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
