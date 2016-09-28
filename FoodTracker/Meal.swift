//
//  Meal.swift
//  FoodTracker
//
//  Created by Sibrian on 9/28/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import Foundation
import UIKit

class Meal {
    var name: String
    var rating: Int
    var photo: UIImage?
    
    init?(name: String, rating: Int, photo: UIImage?) {
        self.name = name
        self.rating = rating
        self.photo = photo
        
        //make the initializer failable by adding a '?' after init
        //the following properties will result in a nil value
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    
}