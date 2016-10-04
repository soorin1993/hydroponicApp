//
//  SchedulerViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/15/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
//import OpenSansSwift
import ParticleSDK
import Foundation

class SchedulerViewController: UIViewController {
    
    
    
    @IBOutlet weak var scheduleTitle: UILabel!
    @IBOutlet weak var relayField: UITextField!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var intervalField: UITextField!
    
    @IBAction func relaySelect(_ sender: UITextField) {
        
        //Create the view
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        datePickerView.datePickerMode = UIDatePickerMode.date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(SchedulerViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(SchedulerViewController.handleDatePicker1(_:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker1(datePickerView) // Set the date on start.
        
    }
    @IBAction func startTime(_ sender: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(SchedulerViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(SchedulerViewController.handleDatePicker2(_:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker2(datePickerView) // Set the date on start.
        
    }
    @IBAction func endTime(_ sender: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        datePickerView.datePickerMode = UIDatePickerMode.date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(SchedulerViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(SchedulerViewController.handleDatePicker3(_:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker3(datePickerView) // Set the date on start.
        
    }
    @IBAction func intervals(_ sender: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        datePickerView.datePickerMode = UIDatePickerMode.date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(SchedulerViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(SchedulerViewController.handleDatePicker4(_:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker4(datePickerView) // Set the date on start.
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scheduleTitle.font = UIFont.openSansFontOfSize(18)
        
    }
    
    func handleDatePicker1(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        relayField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func handleDatePicker2(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        startField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func handleDatePicker3(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func handleDatePicker4(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        intervalField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func doneButton(_ sender:UIButton)
    {
        relayField.resignFirstResponder() // To resign the inputView on clicking done.
        startField.resignFirstResponder()
        endField.resignFirstResponder()
        intervalField.resignFirstResponder()
    }
    


}
