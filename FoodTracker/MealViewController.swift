//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Sibrian on 9/26/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            ratingControl.rating = meal.rating
            photoImageView.image = meal.photo
        }
        
        //enable save if meal name is valid ONLY
        checkForValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        checkForValidMealName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        saveButton.enabled = false
    }
    
    func checkForValidMealName() {
        
        //save button remains disabled for empty string
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    //gesture recognizers can be found in the object library
    @IBAction func selectImageFromLibrary(sender: UITapGestureRecognizer) {
        
        nameTextField.resignFirstResponder()
        
        //specify an image picker controller
        let imagePickerController = UIImagePickerController()
        
        //Photos can only be added from library, not taken on the spot
        imagePickerController.sourceType = .PhotoLibrary
        
        imagePickerController.delegate = self
        
        //show said image picker
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //info hold the original image from the picker as well as the edited version (if it exists)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        photoImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if saveButton === sender {
            let name = nameTextField.text ?? ""     //return text if it has, return empty string otherwise
            let rating = ratingControl.rating
            let photo = photoImageView.image
            
            //set the meal
            meal = Meal(name: name, rating: rating, photo: photo)
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        //check to see if the current view controller is of type UINavigationController
        //if the add button was pressed, the UINavigationController presents the new scene
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    

}

