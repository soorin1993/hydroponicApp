//
//  RelayTableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/28/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK

class RelayTableViewController: UITableViewController {
    
    var relayList = [Relays]()
    var photonDevice: SparkDevice?
    
    var relayDataList = [["relay1", "", "", ""], ["relay2", "", "", ""], ["relay3", "", "", ""], ["relay4", "", "", ""]]
    
    //var relay1: [String] = ["", "", ""]
    //var relay2 = ["", "", ""]
    //var relay3 = ["", "", ""]
    //var relay4 = ["", "", ""]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadRelay()
        
    }
    
    func loadRelay() {
        
        // status
        for index in 0 ... 3 {
            photonDevice!.getVariable(relayDataList[index][0], completion: { (result:AnyObject?, error:NSError?) -> Void in
                if error != nil {
                    print("Failed reading temperature from device")
                }
                else {
                    if let temp = result as? Int {
                        if (temp == 0) {
                            self.relayDataList[index][1] = "OFF"
                            print(self.relayDataList[index][1])

                        }
                        else {
                            self.relayDataList[index][1] = "ON"
                            print(self.relayDataList[index][1])
                        }
                    }
                    var temp = Relays(relayNum: Int(self.relayDataList[index][0])!, relayStat: self.relayDataList[index][1], relayFunc: "???")
                }
            })
        }
        
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RelayTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RelayTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        
        cell.cell_relayNum.text = "1"
        
        
        cell.cell_relayStat.text = "??"
        cell.cell_relayFunc.text = "!!!!"
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;
        
        return cell
    }

}