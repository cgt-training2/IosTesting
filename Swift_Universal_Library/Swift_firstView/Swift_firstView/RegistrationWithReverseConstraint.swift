//
//  RegistrationWithReverseConstraint.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 16/03/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class RegistrationWithReverseConstraint: UIViewController, UITextFieldDelegate {

//    var activeText : UITextField
    
    @IBOutlet var fNameTextField: UITextField!
    
    @IBOutlet var lNameTextField: UITextField!
    
    @IBOutlet var eMailTextField: UITextField!
    
    @IBOutlet var countryTextField: UITextField!
    
    @IBOutlet var uNameTextField: UITextField!
    
    @IBOutlet var passTextField: UITextField!
    
    @IBOutlet var devTextField: UITextField!
    
    @IBOutlet var genderTextField: UITextField!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        fNameTextField.delegate = self
//        lNameTextField.delegate = self
//        eMailTextField.delegate = self
//        countryTextField.delegate = self
//        uNameTextField.delegate = self
//        passTextField.delegate = self
//        devTextField.delegate = self
//        genderTextField.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
//    override func viewWillAppear(animated: Bool) {
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UITextFieldTextDidBeginEditingNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
//        
//    }
//    
//    
//    override func viewWillDisappear(animated: Bool) {
        
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidBeginEditingNotification, object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    @IBAction func submitClicked(sender: AnyObject) {
        
    }

    
    //MARK : TextField Delegate
    
// - (void)textFieldDidBeginEditing:(UITextField *)textField{
//        activeText=textField;
//    }
    
//    func textFieldShouldReturn(textField: UITextField!) -> Bool     {
//        textField.resignFirstResponder()
//        return true;
//    }
    
//    func keyboardDidShow(notification: NSNotification) {
        
//        var kbRect: CGRect = CGRectMake(0, 0, self.view.frame.size.width, 216)
//        kbRect = self.view!.convertRect(kbRect, fromView: nil)
//        var contentInsets: UIEdgeInsets
//        var model: String = UIDevice.currentDevice().model
//        if model.hasPrefix("iPad") {
//            kbRect.size.height = 374
//        }
//        else {
//            kbRect.size.height = 170
//            contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height + 140, 0.0)
//        }
        
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//        contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0)
//        var aRect: CGRect = self.view.frame
        
//        aRect.size.height -= (kbRect.size.height)
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.3)
//        //UIView.animationDelegate = self
//        if CGRectContainsPoint(aRect, activeText.frame.origin) {
//            scrollView.scrollRectToVisible(activeText.frame, animated: false)
//        }
//        UIView.commitAnimations()
    
//    }
    
//    func keyboardWillBeHidden(notification: NSNotification) {
//        var contentInsets: UIEdgeInsets = UIEdgeInsetsZero
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
