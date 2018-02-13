//
//  ViewController.swift
//  FortuneReact
//
//  Created by Alex de France on 12/30/17.
//  Copyright © 2017 Alex de France. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var cityBox: UITextField!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var datePick: UIDatePicker!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func malePress(_ sender: UIButton) {
        if (maleBtn.image(for: .normal) == #imageLiteral(resourceName: "unchecked") && femaleBtn.image(for: .normal) == #imageLiteral(resourceName: "unchecked")) {
            maleBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            femaleBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            maleBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @IBAction func femalePress(_ sender: UIButton) {
        if (maleBtn.image(for: .normal) == #imageLiteral(resourceName: "unchecked") && femaleBtn.image(for: .normal) == #imageLiteral(resourceName: "unchecked")) {
            femaleBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            maleBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            femaleBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }
    
    @IBAction func submitPress(_ sender: UIButton) {
        if (nameBox.layer.borderColor == UIColor.green.cgColor && emailBox.layer.borderColor == UIColor.green.cgColor && cityBox.layer.borderColor == UIColor.green.cgColor && (maleBtn.image(for: .normal) == #imageLiteral(resourceName: "checked") || femaleBtn.image(for: .normal) == #imageLiteral(resourceName: "checked")) && datePick.date != Date()) {
            let alert = UIAlertController(title: "Your Fortune:", message: "You are a champ!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Reset Your Fortune!", style: UIAlertActionStyle.default, handler: { action in
                self.nameBox.text = ""
                self.nameBox.layer.borderColor = UIColor.clear.cgColor
                self.emailBox.text = ""
                self.emailBox.layer.borderColor = UIColor.clear.cgColor
                self.cityBox.text = ""
                self.cityBox.layer.borderColor = UIColor.clear.cgColor
                self.maleBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
                self.femaleBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
                self.datePick.date = Date()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let validName = nameBox.reactive.continuousTextValues.skipNil().map{ (valid) in
//            return DataValidator.validName(name: String)
//        }
        
        datePick.maximumDate = Date()
        self.nameBox.layer.borderWidth = 2.0
        self.nameBox.layer.borderColor = UIColor.clear.cgColor
        self.emailBox.layer.borderWidth = 2.0
        self.emailBox.layer.borderColor = UIColor.clear.cgColor
        self.cityBox.layer.borderWidth = 2.0
        self.cityBox.layer.borderColor = UIColor.clear.cgColor
        
        let validName = nameBox.reactive.continuousTextValues.skipNil().map{ (input) -> Bool in
            return DataValidator.validName(name: input)
        }
        let validEmail = emailBox.reactive.continuousTextValues.skipNil().map{ (input) -> Bool in
            return DataValidator.validEmail(email: input)
        }
        let validCity = cityBox.reactive.continuousTextValues.skipNil().map{ (input) -> Bool in
            return DataValidator.validName(name: input)
        }
        
        validName.map { (valid) -> AnyObject! in
            if valid {
                return UIColor.green
            } else {
                return UIColor.clear
            }
            }.observeValues { (color) in
                
                self.nameBox.layer.borderColor = (color as! UIColor).cgColor
        }
        validEmail.map { (valid) -> AnyObject! in
            if valid {
                return UIColor.green
            } else {
                return UIColor.clear
            }
            }.observeValues { (color) in
                
                self.emailBox.layer.borderColor = (color as! UIColor).cgColor
        }
        validCity.map { (valid) -> AnyObject! in
            if valid {
                return UIColor.green
            } else {
                return UIColor.clear
            }
            }.observeValues { (color) in
                
                self.cityBox.layer.borderColor = (color as! UIColor).cgColor
        }
    }

   


}

