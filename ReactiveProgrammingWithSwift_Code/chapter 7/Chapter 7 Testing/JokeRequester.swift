//
//  JokeRequester.swift
//  Chapter 7 Testing
//
//  Created by Mini Projects on 12/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import Foundation
import ReactiveCocoa

class JokeRequester{
    func signalProducerForJoke(id:Int) -> SignalProducer<[String:AnyObject], NSError> {
        return SignalProducer<[String:AnyObject], NSError>{ (observer:Observer<[String : AnyObject], NSError>, composite:CompositeDisposable) -> () in
            let url = NSURL(string: "http://api.icndb.com/jokes/\(id)")!
            let session = NSURLSession.sharedSession()
            session.dataTaskWithURL(url, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                defer { observer.sendCompleted() }
                guard error == nil else {
                    observer.sendFailed(error!)
                    return
                }
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [String:AnyObject]
                    observer.sendNext(json)
                }catch let error {
                    observer.sendFailed(error as NSError)
                }
            }).resume()
        }
    }
}