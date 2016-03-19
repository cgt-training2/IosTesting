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
    
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        
//        /* Create our configuration first */
//        
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        
//        configuration.timeoutIntervalForRequest = 15.0
//        
//        /* Now create our session which will allow us to create the tasks */
//        
//        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
//        
//    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitClicked(sender: AnyObject) {
        
        let singletonObject = SingletonNSUrlSession.sharedInstance
        
        var jsonDict = NSDictionary()
        let imageData = UIImageJPEGRepresentation(imgProfile.image!, 1)
        
        let myUrl : String = "http://www.cgtechnosoft.net/delivit/api/register/"
        
        let param = ["first_name" : fNameTextField.text!,"last_name" : lNameTxtField.text!, "email" : eMailTxtField.text!, "country" : countryTxtField.text!, "gender" : genderTxtField.text!, "username" : uNameTxtField.text!, "password" : passTxtField.text!, "device_id" : devIdTxtField.text!]
        
            jsonDict = singletonObject.myImageUploadRequest(myUrl, param: param, filePath: "photo", imageData: imageData!)
            print("Dictionary is:",jsonDict)
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


