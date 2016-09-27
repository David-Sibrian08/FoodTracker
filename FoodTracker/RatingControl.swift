//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Sibrian on 9/27/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Rating Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    //called every time the property is changed. A layout update will be performed every time rating changes.
    
    var ratingButtons = [UIButton]()        //create an array of rating buttons (stars)
    
    let spacing = 5                         //there will be 5 pixels between each star
    let starCount = 5                       //there will be 5 stars total

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        //create 5 buttons (they will stack one on top of the other at first)
        for _ in 0..<starCount {
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)      //empty star for unselected
            button.setImage(filledStarImage, forState: .Selected)   //filled star when selected
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])   //filled when user is selecting
            
            button.adjustsImageWhenHighlighted = false
            
            //conect the button to the storyboard in code
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            
            //add each created button to the array
            ratingButtons += [button]
            
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)     //set the height of the button
        
        //create a frame for the button
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
    
        //each button is paired with an index (due to enumerate())
        //
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        //based on the above math, star buttons should start at x = 0, 49, 98, 147 & 196
        updateButtonSelectionStates()
        //button states should change when view loads not only when rating is changed
    }
    
    //return the size of the rating control frame
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)     //44px
        
        //44 * 5 = 220 + (5 * (5 - 1) = 240px width
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        //match the size specified in interface builder
        //return a frame of 240 x 44
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating
            
            //if the index in the array is less than the rating, select it
        }
    }

}
