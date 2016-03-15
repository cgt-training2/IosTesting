//
//  SecondViewController.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 21/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textFieldDatePick: UITextField!
    @IBOutlet weak var toolBarItem: UIToolbar!
    @IBOutlet weak var toolbarMargin: NSLayoutConstraint!
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var marginDatePick: NSLayoutConstraint!
    
    let pickerData = ["Nothing", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIPickerView()
        textFieldDatePick.userInteractionEnabled=true
        textFieldDatePick.delegate=self
            // creates a navigation button.
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "navigate", style: .Plain, target: self, action: "navigate:")
    }
    
    // MARK: action of navigation bar button item.
    
    func navigate(sender:UIBarButtonItem){
        
        let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("locationUpdate") as! LocationManagerViewController
        self.navigationController?.pushViewController(locationViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK : UIPickerView Delegate Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        //if (pickerView == picker){
            return 1
        //}
          //  return 0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
        //return 10
        return pickerData.count
    }
    
    @IBAction func doneBtnTapped(sender: AnyObject) {
        print("Done Button tapped")
        
        toolBarItem.layoutIfNeeded()
        UIView.animateWithDuration(1, animations: {
            self.toolbarMargin.constant=225
            self.toolBarItem.layoutIfNeeded()
        })
        
        datePicker1.layoutIfNeeded()
        UIView.animateWithDuration(1, animations: {
            self.marginDatePick.constant=250
            self.datePicker1.layoutIfNeeded()
        })
    }

    
    @IBAction func toolBarCancel(sender: AnyObject) {
        textFieldDatePick.text = ""
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        //return " \(row + 1) "
        return pickerData[row]
    }
    

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
    }
    
    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() //to hide the keyboard.
        return true //returning the value true indicates that the text field should respond to the user pressing the Return                                 key by dismissing the keyboard.
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        return false
    }
    
    
    //MARK: DatePicker function

    @IBAction func textFieldaction(sender: UITextField) {
        print("Hello TextField")
        datePicker1.hidden=false
        datePicker1.datePickerMode=UIDatePickerMode.Date

       // Used to animate the UIDatePicker view appearance.
        toolBarItem.layoutIfNeeded()
        UIView.animateWithDuration(1, animations: {
                self.toolbarMargin.constant=5
                self.toolBarItem.layoutIfNeeded()
        })
        datePicker1.layoutIfNeeded()
        UIView.animateWithDuration(1, animations: {
            self.marginDatePick.constant=54
            self.datePicker1.layoutIfNeeded()
        })
    
    }
    
    
    @IBAction func datePickAction(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString:String = formatter.stringFromDate(sender.date)
        textFieldDatePick.text="\(dateString)"
    }
    
}

