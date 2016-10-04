//
//  Sensors.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/29/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit

class Sensors {
    
    // MARK: Properties
    var sensorNum: String
    var sensorVal: String
    var sensorFunc: String
    var sensorRelay: String?
    
    // MARK: Initialization
    init?(sensorNum: String, sensorVal: String, sensorFunc: String, sensorRelay: String?) {
        // Initialize stored properties.
        self.sensorNum = sensorNum
        self.sensorVal = sensorVal
        self.sensorFunc = sensorFunc
        self.sensorRelay = sensorRelay
        
        // Initialization should fail if ther e is no name or if the rating is negative.
    }
    
    
}