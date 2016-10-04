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
    
    @IBOutlet weak var cell_relayNum: UILabel!
    @IBOutlet weak var cell_relayStat: UILabel!
    @IBOutlet weak var cell_relayFunc: UILabel!
    @IBOutlet weak var cell_relaySwitch: UISwitch!
    @IBOutlet weak var cell_relayImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cell_relayNum.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
        cell_relayStat.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)
        cell_relayFunc.textColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha:1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
