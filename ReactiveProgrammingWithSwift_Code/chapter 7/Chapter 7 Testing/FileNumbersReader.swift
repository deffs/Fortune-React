//
//  FileNumbersReader.swift
//  Chapter 7 Testing
//
//  Created by Mini Projects on 11/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import Foundation
import ReactiveCocoa

class FileNumbersReader {
    func signalProducerForFile(filePath:String) -> SignalProducer <Int, NSError> {
        return SignalProducer<Int, NSError> { (observer: Observer<Int, NSError>, disposable: CompositeDisposable) -> () in
            defer {
                observer.sendCompleted()
            }
            let fileManager = NSFileManager.defaultManager()
            guard let content = fileManager.contentsAtPath(filePath) else {
                let error = NSError(domain: "FileNumbersReader", code: 100, userInfo: [NSLocalizedDescriptionKey: "Can't open file"])
                observer.sendFailed(error)
                return
            }
            
            guard let stringContent = String(data: content, encoding: NSUTF8StringEncoding) else {
                let error = NSError(domain: "FileNumbersReader", code: 101, userInfo: [NSLocalizedDescriptionKey: "File content is not a text"])
                observer.sendFailed(error)
                return
            }

            let tokens = stringContent.characters.split { $0 == " "}.map( String.init )
            tokens.forEach { (value:String) -> () in
                if let number = Int(value) {
                    observer.sendNext(number)
                }
            }
        } // end SignalProducer
        
    } // end signalProducerForFile
} // end FileNumbersReader

