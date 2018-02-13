//
//  ViewController.swift
//  Chapter 7 Testing
//
//  Created by Mini Projects on 08/12/2015.
//  Copyright © 2015 Packt Pub. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var requesterButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileNumbersReader = FileNumbersReader()
        let path = NSBundle(forClass: self.classForCoder).resourcePath!
        let fullPath = "\(path)/selectedjokes.txt"
        let fileNumbersReaderSignal = fileNumbersReader.signalProducerForFile(fullPath)
        
        let buttonSignal = requesterButton.rac_signalForControlEvents(.TouchUpInside)
            .toSignalProducer()
        
        fileNumbersReaderSignal.zipWith(buttonSignal)
            .flatMap(.Latest) {
                (jokeNumber:Int, _:AnyObject?) -> SignalProducer<[String:AnyObject], NSError> in
                let jokeRequester = JokeRequester()
                return jokeRequester.signalProducerForJoke(jokeNumber)
            }
            .map { (input:[String : AnyObject]) -> String in
                let value = input["value"] as! [String:AnyObject]
                let joke = value["joke"] as! String
                return joke
            }
            .observeOn(UIScheduler())
            .startWithNext {[weak self] (joke:String) -> () in
                self?.jokeLabel.text = joke
        }
    }// end viewDidLoad
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

