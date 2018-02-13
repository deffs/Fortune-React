//
//  FileNumbersReaderTests.swift
//  Chapter 7 Testing
//
//  Created by Mini Projects on 11/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import XCTest
@testable import Chapter_7_Testing
import ReactiveCocoa

class FileNumbersReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testFileNotFound() {
        var errorFound = false
        let fileNumbersReader = FileNumbersReader()
        let signalProducer = fileNumbersReader.signalProducerForFile("nonexistingfile.txt")
        signalProducer.on(failed: { (error:NSError) -> () in
                XCTAssertEqual(100, error.code, "Wrong error code")
                errorFound = true
            }) { (_:Int) -> () in
                XCTAssert(false, "Wrong way")
        }.start()
        XCTAssertTrue(errorFound, "No error was triggered")
    }
    
    func testBinaryFile() {
        var errorFound = false
        let fileNumbersReader = FileNumbersReader()
        
        let path = NSBundle(forClass: self.classForCoder).resourcePath!
        let fullPath = "\(path)/pato.png"
        
        let signalProducer = fileNumbersReader.signalProducerForFile(fullPath)
        signalProducer.on(failed: { (error: NSError) -> () in
            XCTAssertEqual(101, error.code, "Wrong error code")
            errorFound = true
            }) { (value:Int) -> () in
                XCTAssert(false, "Wrong way")
            }.start()
        XCTAssertTrue(errorFound, "No error was triggered")
        
    }
    
    func testValues(){
        let signalValues = SignalProducer<Int, NSError>{ (observer: Observer<Int, NSError>, disposable: CompositeDisposable) -> () in
            [10, 20, 30, 40].forEach({ (value:Int) -> () in
                observer.sendNext(value)
            })
            observer.sendCompleted()
        }
        
        let fileNumbersReader = FileNumbersReader()
        let path = NSBundle(forClass: self.classForCoder).resourcePath!
        let fullPath = "\(path)/numbers.txt"
        let signalProducer = fileNumbersReader.signalProducerForFile(fullPath)
        
        signalProducer.on(failed: { (error: NSError) -> () in
            XCTAssert(false, "Unexpected error: \(error.localizedDescription)")
            })
            .zipWith(signalValues)
            .startWithNext { (value:Int, expectedValue:Int) -> () in
                XCTAssertEqual(value, expectedValue, "Value \(value) is different from it's expectation \(expectedValue)")
        }
    } // end testValues
    
}
