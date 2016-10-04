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

var loggedIn: Bool = false


class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if loggedIn {
        
            SparkCloud.sharedInstance().logout()
            print("logout")
        }
                
        username.layer.borderWidth = 1.0
        username.layer.borderColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1).cgColor

        username.delegate = self
        username.text = ""
        
        username.keyboardType = UIKeyboardType.emailAddress
        
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1).cgColor

        password.delegate = self
        password.text = ""

        /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
         */
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
            let alert = UIAlertController(title: "Error", message: "Please enter your credentials for Particle", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Button", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
        
        //print(particleUserName)
        //print(particlePassword)
        
        SparkCloud.sharedInstance().login(withUser: particleUserName, password: particlePassword) { (error:Error?) -> Void in
            if error != nil {
                print("Wrong credentials or no internet connectivity, please try again")
                let alert = UIAlertController(title: "Error", message: "Wrong credentials or no internet connectivity, please try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Button", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("Logged in")
                loggedIn = true
                self.performSegue(withIdentifier: "tableView", sender: self)
                
            }
        }
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        
        loginSetup()
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }
    
}

