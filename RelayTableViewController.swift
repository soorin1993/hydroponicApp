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
    var counter = 0
    var timer1: Timer?
    var timer2: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.tableView.isMultipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
                
        self.tableView.reloadData()
        
        if (counter == 0) {
            timer1 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RelayTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(RelayDeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)

        
        loadRelay()
        
        self.refreshControl?.addTarget(self, action: #selector(RelayTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func update() {
        
        self.tableView.reloadData()
        
    }
    
    func autoUpdate() {
        
        loadRelay()
        self.tableView.reloadData()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
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
            
            photonDevice!.getVariable(relayVars[index], completion: { (result:Any?, error:Error?) -> Void in
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
                    var foobar = Relays(relayNum: relayNum, relayStat: stat, relayFunc: "???", relaySensor: nil)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return relayList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "relayTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RelayTableViewCell
        
        let relayItem = relayList[(indexPath as NSIndexPath).row]

        relayList.sort(by: { $0.relayNum < $1.relayNum })

        cell.cell_relayNum.text = relayItem.relayNum
        cell.cell_relayStat.text = relayItem.relayStat
        cell.cell_relayFunc.text = relayItem.relayFunc
        
        if relayItem.relayStat == "OFF" {
            cell.cell_relaySwitch.isOn = false
            cell.cell_relayImg.image = UIImage(named: "off")

        }
        else {
        
            cell.cell_relaySwitch.isOn = true
            cell.cell_relayImg.image = UIImage(named: "on")

        }

        cell.selectionStyle = UITableViewCellSelectionStyle.gray;

        return cell
    }

    @IBAction func relaySwithChange(_ sender: UISwitch) {
        
        let view = sender.superview!
        let cell1 = view.superview as! RelayTableViewCell
        let indexPath = tableView.indexPath(for: cell1)
        let cell = tableView.cellForRow(at: indexPath!) as! RelayTableViewCell
        let relayItem = relayList[(indexPath! as NSIndexPath).row]
        
        if cell.cell_relaySwitch.isOn == true {
            
            relayItem.relayStat = "..."

            var relayName = String(relayItem.relayNum)
            
            let funcArgs = [relayName]
            _ = photonDevice!.callFunction("set", withArguments: funcArgs) { (resultCode : NSNumber?, error : Error?) -> Void in
                if (error == nil) {
                    print("Turned on ", relayName)
                }
            }

        }
        else {
            
            relayItem.relayStat = "..."
            
            var relayName = String("1" + relayItem.relayNum)
            
            let funcArgs = [relayName]
            var task = photonDevice!.callFunction("set", withArguments: funcArgs) { (resultCode : NSNumber?, error : Error?) -> Void in
                if (error == nil) {
                    print("Turned off ", relayName)
                }
            }
                    }
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.autoUpdate()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer1!.invalidate()
        timer2!.invalidate()
    }

}
