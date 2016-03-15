//
//  ViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 19/01/16.
//  Copyright (c) 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // IBOUTLETS given in the class.
    
    @IBOutlet weak var labelMeal: UILabel!
    @IBOutlet weak var textFieldMeal: UITextField!
    @IBOutlet weak var imgViewDefault: UIImageView!
    
//    profilPicture.layer.borderWidth = 1
//    profilPicture.layer.borderColor = UIColor.blackColor().CGColor
//    profilPicture.layer.cornerRadius = profilPicture.frame.height/2
    var controller:UIAlertController?
    var alertEditText:String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textFieldMeal.delegate=self
        
        // MARK: to make a circular image do following:
        imgViewDefault.layer.borderWidth = 1
        imgViewDefault.layer.borderColor = UIColor.blackColor().CGColor
        //imgViewDefault.layer.cornerRadius = 65
        //imgViewDefault.layer.masksToBounds = true
        imgViewDefault.layer.cornerRadius = imgViewDefault.frame.height/2
        //imgViewDefault.clipsToBounds = false
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigate:")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func navigate(sender:UIBarButtonItem){
        //print("Navigate Clicked")
        
          let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("secondView") as! SecondViewController
          self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // IB-Actions given in the function:
    
    
    
    @IBAction func clickMeMeal(sender: AnyObject) {
        labelMeal.text=textFieldMeal.text
        alertEditText=labelMeal.text!
        
        controller=UIAlertController(title: "Rating", message: "rating is \(alertEditText)", preferredStyle: .Alert)
        let action=UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in print("Done Button Tapped")
        })
        controller!.addAction(action)
        
       presentViewController(controller!, animated: true, completion: nil)
       // AlertViewControllerFunc()
        
    }

    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        textFieldMeal.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
   
    
    // ***************************DELEGATE Methods*****************************
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //to hide the keyboard.
        return true //returning the value true indicates that the text field should respond to the user pressing the Return key by dismissing the keyboard.
    
    }
    
    //This method will be called after the textFieldShouldReturn method you just implemented.
    
    // The textFieldDidEndEditing(_:) method gives you a chance to read the information entered into the text field and do something with it.
    
    func textFieldDidEndEditing(textField: UITextField) {
        labelMeal.text=textField.text
    }
    
    // MARK:: "Image-Picker Delegates."
    
    // Controls the picking of the image.
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        // Select Image from the PhotoLibrary
        let selectedImage=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Set the selected image to image View
        
        imgViewDefault.image=selectedImage

       // enables the animation to cancel the image picker.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
     //The first of these, imagePickerControllerDidCancel(_:), gets called when a user taps the image picker’s Cancel button. This method gives you a chance to dismiss the UIImagePickerController (and optionally, do any necessary cleanup). Implement imagePickerControllerDidCancel(_:) to do that.
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // enables the animation to cancel the image picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
}


    //        func requiredHeight() -> CGFloat{
    //
    //            let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
    //            label.numberOfLines = 0
    //            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    //            label.font = self.font
    //            label.text = self.text
    //
    //            label.sizeToFit()
    //
    //            return label.frame.height
    //        }


