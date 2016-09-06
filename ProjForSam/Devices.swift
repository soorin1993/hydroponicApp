//
//  Devices.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit

class Devices {

    // MARK: Properties
    var deviceName: String
    var deviceStat: Bool
    var deviceVal: String
    var deviceLoc: String
    
    // MARK: Initialization
    init?(deviceName: String, deviceStat: Bool, deviceVal: String, deviceLoc: String) {
        // Initialize stored properties.
        self.deviceName = deviceName
        self.deviceStat = deviceStat
        self.deviceVal = deviceVal
        self.deviceLoc = deviceLoc
        
        // Initialization should fail if ther e is no name or if the rating is negative.
        if (deviceName.isEmpty){
            return nil
        }
    }

    
}
