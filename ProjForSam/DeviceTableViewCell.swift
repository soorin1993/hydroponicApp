//
//  TableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import Foundation
import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cell_imageView: UIImageView!
    
    @IBOutlet weak var cell_deviceID_label: UILabel!
    @IBOutlet weak var cell_deviceStat_label: UILabel!
    @IBOutlet weak var cell_deviceVal_label: UILabel!
    @IBOutlet weak var cell_deviceLoc_label: UILabel!
    
    @IBOutlet weak var cell_deviceID: UILabel!
    @IBOutlet weak var cell_deviceStat: UILabel!
    @IBOutlet weak var cell_deviceVal: UILabel!
    @IBOutlet weak var cell_deviceLoc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
