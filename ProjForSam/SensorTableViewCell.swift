//
//  SensorTableViewCell.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/29/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit

class SensorTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_sensorNum: UILabel!
    @IBOutlet weak var cell_sensorVal: UILabel!
    @IBOutlet weak var cell_sensorFunc: UILabel!
    @IBOutlet weak var cell_sensorRelay: UILabel!
    @IBOutlet weak var cell_sensorImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
