//
//  ViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK
import Foundation

let username1: String = "soorin1993@gmail.com"
let password1: String = "Leh082393"

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        username.layer.borderWidth = 1.0
        username.layer.borderColor = UIColor.grayColor().CGColor
        username.delegate = self
        
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        loginSetup()
        return true
    }

    func loginSetup() {
    
        //let particleUserName: String = username.text!
        //let particlePassword: String = password.text!
        
        let particleUserName: String = "soorin1993@gmail.com"
        let particlePassword: String = "Leh082393"
        
        if (particleUserName.isEmpty || particlePassword.isEmpty) {
        
            let alert = UIAlertController(title: "Error", message: "Please enter your credentials for Particle", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Button", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        }
        
        print(particleUserName)
        print(particlePassword)
        
        SparkCloud.sharedInstance().loginWithUser(particleUserName, password: particlePassword) { (error:NSError?) -> Void in
            if error != nil {
                print("Wrong credentials or no internet connectivity, please try again")
                let alert = UIAlertController(title: "Error", message: "Wrong credentials or no internet connectivity, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Button", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                print("Logged in")
                self.performSegueWithIdentifier("tableView", sender: self)
                
            }
        }
    }
    
    @IBAction func loginClick(sender: UIButton) {
        
        loginSetup()
        
    }
    
}

