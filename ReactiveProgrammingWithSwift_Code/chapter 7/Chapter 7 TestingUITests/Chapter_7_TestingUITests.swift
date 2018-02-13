//
//  Chapter_7_TestingUITests.swift
//  Chapter 7 TestingUITests
//
//  Created by Mini Projects on 08/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import XCTest

class Chapter_7_TestingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicOperation() {
        
        let app = XCUIApplication()
        let nextJokeButton = app.buttons["Next joke"]
        nextJokeButton.tap()
        app.staticTexts["When Chuck Norris goes to donate blood, he declines the syringe, and instead requests a hand gun and a bucket."].tap()
        nextJokeButton.tap()
        app.staticTexts["Chuck Norris doesn't shower, he only takes blood baths."].tap()
        nextJokeButton.tap()
        app.staticTexts["Teenage Mutant Ninja Turtles is based on a true story: Chuck Norris once swallowed a turtle whole, and when he crapped it out, the turtle was six feet tall and had learned karate."].tap()
        nextJokeButton.tap()
        
        let chuckNorrisDoesnTReadBooksHeStaresThemDownUntilHeGetsTheInformationHeWantsStaticText = app.staticTexts["Chuck Norris doesn't read books. He stares them down until he gets the information he wants."]
        chuckNorrisDoesnTReadBooksHeStaresThemDownUntilHeGetsTheInformationHeWantsStaticText.tap()
        nextJokeButton.tap()
        chuckNorrisDoesnTReadBooksHeStaresThemDownUntilHeGetsTheInformationHeWantsStaticText.tap()
        // Use recording to get started writing UI tests.
    }
    
}
