//
//  MealViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 28/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    
    @IBOutlet var saveButton2: UIBarButtonItem!
    @IBOutlet var imageMeal1: UIImageView!
    @IBOutlet var ratingControlOutlet1: RatingControlClass!
    @IBOutlet var mealTextField1: UITextField!
    
    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new meal.
    */
    
    var meal: Meal?
    var meal1:Meal1?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTextField1.delegate=self
        
        self.navigationItem.rightBarButtonItem=saveButton2
        
        if let meal = meal{
            navigationItem.title = meal.name
            mealTextField1.text = meal.name
            imageMeal1.image = meal.photo
            ratingControlOutlet1.rating = meal.rating
        }
        checkValidMealName()
    }
    
    
    func checkValidMealName(){
        let text=mealTextField1.text ?? ""
        saveButton2.enabled = !text.isEmpty
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        saveButton2.enabled = true
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        saveButton2.enabled = false
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Select Image from the PhotoLibrary
        let selectedImage=info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Set the selected image to image View
        imageMeal1.image = selectedImage
        
        // enables the animation to cancel the image picker.
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: Action
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // (===) is the identity Operator to check that the object referenced by the saveButton2 outlet is the same object instance as sender.
        
        if(saveButton2 === sender){
            
            // Notice the nil coalescing operator (??) in the name line. The nil coalescing operator is used to return the value of an optional if the optional has a value, or return a default value otherwise.
            
                let mealName = mealTextField1.text ?? ""
                let image = imageMeal1.image
                let ratingControl = ratingControlOutlet1.rating
            
                // Add the values to the Meal object.
                meal = Meal(name: mealName, photo: image, rating: ratingControl)
            
        }
    }
    
    @IBOutlet var pickImages1: UITapGestureRecognizer!

    @IBAction func pickImageGesture(sender: UITapGestureRecognizer) {
        
        print("Pick Image")
        mealTextField1.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        
        let imagePickercontroller = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        
        imagePickercontroller.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        
        imagePickercontroller.delegate = self
        
        presentViewController(imagePickercontroller, animated: true, completion: nil)
        
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
