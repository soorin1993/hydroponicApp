//
//  SensorDeviceTableViewCell.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/29/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import Foundation
import UIKit

class SensorDeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_deviceID: UILabel!
    @IBOutlet weak var cell_deviceStat: UILabel!
    @IBOutlet weak var cell_deviceVal: UILabel!
    @IBOutlet weak var cell_deviceLoc: UILabel!
    
    @IBOutlet weak var cell_deviceImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
