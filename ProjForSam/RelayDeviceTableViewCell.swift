//
//  TableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import Foundation
import UIKit

class RelayDeviceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cell_imageView: UIImageView!
    @IBOutlet weak var cell_deviceID: UILabel!
    @IBOutlet weak var cell_deviceStat: UILabel!
    @IBOutlet weak var cell_deviceVal: UILabel!
    @IBOutlet weak var cell_deviceLoc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cell_deviceID.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
        cell_deviceStat.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
        cell_deviceVal.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
        cell_deviceLoc.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
