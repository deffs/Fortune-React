//
//  Chapter_7_TestingTests.swift
//  Chapter 7 TestingTests
//
//  Created by Mini Projects on 08/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import XCTest
@testable import Chapter_7_Testing
import ReactiveCocoa

class Chapter_7_TestingTests: XCTestCase {
    
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
    
    func testMutableValue(){
        let firstValue = MutableProperty<Int>(10)
        let secondValue = MutableProperty<Int>(0)
        firstValue.producer.startWithNext { (input:Int) -> () in
            secondValue.value += input
        }
        XCTAssertEqual(secondValue.value, 10)
        firstValue.value *= 5
        firstValue.value = secondValue.value / 10
        XCTAssertEqual(secondValue.value, 66)
    } // end testMutableValue
    
}
