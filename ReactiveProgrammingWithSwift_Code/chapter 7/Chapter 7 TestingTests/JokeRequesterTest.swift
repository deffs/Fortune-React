//
//  JokeRequesterTest.swift
//  Chapter 7 Testing
//
//  Created by Mini Projects on 12/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import XCTest
@testable import Chapter_7_Testing

class JokeRequesterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJoke40() {
        let expectation = expectationWithDescription("Expectation")
        let jokeRequester = JokeRequester()
        let signalProducer = jokeRequester.signalProducerForJoke(40)
        signalProducer.startWithNext { (input:[String : AnyObject]) -> () in
            XCTAssertNotNil(input["value"], "no value field")
            if let value = input["value"] as? [String:AnyObject] {
                XCTAssertEqual(value["joke"] as? String, "A handicapped parking sign does not signify that this spot is for handicapped people. It is actually in fact a warning, that the spot belongs to Chuck Norris and that you will be handicapped if you park there.")
                expectation.fulfill()
            }else {
                XCTAssertTrue(false, "can't convert the 'value' field")
            }
        }
        waitForExpectationsWithTimeout(5, handler: nil)
    }



}
