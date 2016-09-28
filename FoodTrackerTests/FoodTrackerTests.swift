//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Sibrian on 9/26/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: FoodTracker Tests
    func testMealInitialization() {
        
        //passing case
        let passingMeal = Meal(name: "Delicious Meal", rating: 5, photo: nil)
        XCTAssertNotNil(passingMeal)    //test for 'not nil'
        
        //failing case (bad name & rating)
        let failingMeal = Meal(name: "", rating: -1, photo: nil)
        XCTAssertNil(failingMeal, "Empty name & negative rating is invalid")
        
        //failing case (bad rating)
        let anotherFailedMeal = Meal(name: "No Bueno", rating: -5, photo: nil)
        XCTAssertNil(anotherFailedMeal, "Really bad ratings not allowed")
    }
    //write small modular test cases. Any more complex and unexpected behavior becomes harder to catch
}
