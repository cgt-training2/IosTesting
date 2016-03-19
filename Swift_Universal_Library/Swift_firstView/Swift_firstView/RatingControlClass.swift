
//  RatingControlClass.swift
//  Swift_firstView
//
//  Created by Bhuvan Sharma on 21/01/16.
//  Copyright © 2016 CGT TECHNOSOFT. All rights reserved.



// The rating control will let users choose 0, 1, 2, 3, 4, or 5 stars for a meal. When a user taps a star, all stars leading up to and including that star (from the left) are filled in. A filled-in star counts as a rating; an empty star doesn’t.


import UIKit

class RatingControlClass: UIView {

    //  Every UIView subclass that implements an initializer must include an implementation of init?(coder:). The Swift compiler knows this, and offers a fix-it to make this change in your code. Fix-its are provided by the compiler as potential solutions to errors in your code.

            // MARK: Properties
    
    
    // A property observer observes and responds to changes in a property’s value. Specifically, the didSet property observer is called immediately after the property’s value is set. Here, you include a call to setNeedsLayout(), which will trigger a layout update every time the rating changes. This ensures that the UI is always showing an accurate representation of the rating property value.
    
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    
    
    
    var ratingButtons = [UIButton]()
   
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        // Used to initialize the Images variable.
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<5{
            
            let button = UIButton()
  
            //    frame: CGRect(x: 0, y: 0, width: 44, height: 44)

            //  You’re setting two different images for different states so you can see when the buttons have been selected. The empty star image appears when a button is unselected (.Normal state). The filled-in star image appears when the button is selected (.Selected state) and when the button is both selected and highlighted (.Selected and .Highlighted states), which occurs when a user is in the process of tapping the button.
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            //button.backgroundColor = UIColor.redColor()
            
            // This is to make sure that the image doesn’t show an additional highlight during the state change.
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            // As you create each button, you add it to the ratingButtons array to keep track of it.
            ratingButtons+=[button]
            addSubview(button)
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    
    // MARK: Action
    
    func ratingButtonTapped(button:UIButton){
        //print("Button Tapped")
        rating=ratingButtons.indexOf(button)!+1
        updateButtonSelectionStates()
        
        
        
    }
    
    //  This type of layout code belongs in a method called layoutSubviews, a method defined on the UIView class. The layoutSubviews method gets called at the appropriate time by the system and gives UIView subclasses a chance to perform a precise layout of their subviews. You’ll need to override this method to place the buttons appropriately.

    override func layoutSubviews() {
        var buttonFrame = CGRect(x:0,y:0, width:44, height: 44);
            // Offset each button's origin by the length of the button plus spacing.
        
        for(index , button) in ratingButtons.enumerate(){
            buttonFrame.origin.x=CGFloat(index*(44+2))
            button.frame=buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        print(rating)
        for(index,button) in ratingButtons.enumerate(){
            button.selected=index < rating
        }
    }
}


   // ******************************* MARK: To Declare Constants ************************************

//override func layoutSubviews() {
//    // Set the button's width and height to a square the size of the frame's height.
//    let buttonSize = Int(frame.size.height)
//    var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
//    
//    // Offset each button's origin by the length of the button plus some spacing.
//    for (index, button) in ratingButtons.enumerate() {
//        buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
//        button.frame = buttonFrame
//    }
//}

//override func intrinsicContentSize() -> CGSize {
//    let buttonSize = Int(frame.size.height)
//    let width = (buttonSize + spacing) * stars
//    
//    return CGSize(width: width, height: buttonSize)
//}






