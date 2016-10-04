//
//  Devices.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit

class Relays {
    
    // MARK: Properties
    var relayNum: String
    var relayStat: String
    var relayFunc: String
    var relaySensor: String?
    
    // MARK: Initialization
    init?(relayNum: String, relayStat: String, relayFunc: String, relaySensor: String?) {
        // Initialize stored properties.
        self.relayNum = relayNum
        self.relayStat = relayStat
        self.relayFunc = relayFunc
        self.relaySensor = relaySensor
        
        // Initialization should fail if ther e is no name or if the rating is negative.
    }
    
    
}
