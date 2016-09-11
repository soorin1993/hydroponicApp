//
//  RelayTableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/28/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK

protocol SettingCellDelegate : class {
    func switchChangeAction(sender: RelayTableViewCell, isOn: Bool)
}

class RelayTableViewController: UITableViewController, SettingCellDelegate {
    
    var relayList = [Relays]()
    var photonDevice: SparkDevice?
    var counter = 0
    var timer1: NSTimer?
    var timer2: NSTimer?
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.tableView.multipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
                
        self.tableView.reloadData()
        
        if (counter == 0) {
            timer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(RelayTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        /*
        timer2 = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(RelayTableViewController.autoUpdate), userInfo: nil, repeats: true)
        */
        
        loadRelay()
        
        self.refreshControl?.addTarget(self, action: #selector(RelayTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func update() {
        
        self.tableView.reloadData()
        
    }
    
    func autoUpdate() {
        
        loadRelay()
        self.tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        loadRelay()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadRelay() {
        
        relayList.removeAll()
        
        let relayVars = Array(photonDevice!.variables.keys)
        let deviceFuncs = photonDevice!.functions
        
        var stat: String!
        
        for index in 0 ... (relayVars.count - 1) {
            
            photonDevice!.getVariable(relayVars[index], completion: { (result:AnyObject?, error:NSError?) -> Void in
                if error != nil {
                    print("Failed reading from device")
                }
                else {
                    if let temp = result as? Float {
                        if (temp == 0) {
                            stat = "OFF"
                        }
                        else {
                            stat = "ON"
                        }
                    }
                    var relayNum = String(index + 1)
                    var foobar = Relays(relayNum: relayNum, relayStat: stat, relayFunc: "???")
                    self.relayList.append(foobar!)
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
        return relayList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RelayTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RelayTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let relayItem = relayList[indexPath.row]

        relayList.sortInPlace({ $0.relayNum < $1.relayNum })

        
        
        cell.cell_relayNum.text = relayItem.relayNum
        cell.cell_relayStat.text = relayItem.relayStat
        cell.cell_relayFunc.text = relayItem.relayFunc
        
        /*
        if relayItem.relayStat == "OFF" {
        
            cell.cell_relayImg.image = UIImage(named: "sleeping_dog")
        }
        else {
        
            cell.cell_relayImg.image = UIImage(named: "awake_dog")
        }*/

        /*
        cell.cell_relaySwitch.tag = indexPath.row
        cell.cell_relaySwitch.addTarget(self, action: Selector("switchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        */
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;
        
        cell.cellDelegate = self

        
        return cell

    }
    
    
    func switchChangeAction(sender: RelayTableViewCell, isOn: Bool) {
        
        let indexPath = self.tableView.indexPathForCell(sender)
        let cell = tableView.dequeueReusableCellWithIdentifier("RelayTableViewCell", forIndexPath: indexPath!) as! RelayTableViewCell
        print(indexPath)
        
        print("HI")
        if isOn {
            cell.cell_relayStat.text = "ON"
        }
        else {
            cell.cell_relayStat.text = "OFF"
        }
    }
/*
    @IBAction func switchChanged(sender: UISwitch) {
    //}
    //func switchChanged(sender: UISwitch) {
        
        var row = sender.tag
        print("row", row)

        var indexPath = NSIndexPath(forRow: row, inSection: 0)
        let cell = tableView.dequeueReusableCellWithIdentifier("RelayTableViewCell", forIndexPath: indexPath) as! RelayTableViewCell

        //var cell = tableView.cellForRowAtIndexPath(indexPath) as! RelayTableViewCell
        print("HI")
        if sender.on {
            cell.cell_relayStat.text = "ON"
        }
        else {
            cell.cell_relayStat.text = "OFF"
        }
    }
 */
    
    

}