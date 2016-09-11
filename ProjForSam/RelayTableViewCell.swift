//
//  RelayTableViewCell.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/28/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK

class RelayTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var cell_relayImg: UIImageView!
    @IBOutlet weak var cell_relayNum: UILabel!
    @IBOutlet weak var cell_relayStat: UILabel!
    @IBOutlet weak var cell_relayFunc: UILabel!
    @IBOutlet weak var cell_relaySwitch: UISwitch!
    
    weak var cellDelegate: SettingCellDelegate?

    
    @IBAction func switchChanged(sender: UISwitch) {
        
        self.cellDelegate?.switchChangeAction(self, isOn:cell_relaySwitch.on)

    }
    
   
    @IBOutlet weak var relayImg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
