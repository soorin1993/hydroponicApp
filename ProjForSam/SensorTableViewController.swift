//
//  SensorTableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/29/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK

class SensorTableViewController: UITableViewController {

    var sensorList = [Sensors]()
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
            timer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(SensorDeviceTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        timer2 = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(RelayDeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)

        
        loadSensor()
        
        self.refreshControl?.addTarget(self, action: #selector(RelayTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
    func update() {
        
        self.tableView.reloadData()
        
    }
    
    func autoUpdate() {
        
        loadSensor()
        self.tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        loadSensor()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadSensor() {
        
        sensorList.removeAll()
        
        let sensorVars = Array(photonDevice!.variables.keys)
        let sensorFuncs = photonDevice!.functions
        
        var function: String!
        var val: Double!
        
        for index in 0 ... (sensorVars.count - 1) {
            
            photonDevice!.getVariable(sensorVars[index], completion: { (result:AnyObject?, error:NSError?) -> Void in
                if error != nil {
                    print("Failed reading from device")
                }
                else {
                    if let foo = result as? Double {
                        
                        // temp
                        if (sensorVars[index].rangeOfString("Temp") != nil) {
                            val = foo
                            print(val)
                            function = "Temperature"
                            
                        }
                        // humidity
                        else if (sensorVars[index].rangeOfString("Hum") != nil) {
                            val = foo
                            function = "Humidity"
                        }
                        
                        print(String(format:"%.2f", val))
                        var foobar = Sensors(sensorNum: String(self.sensorList.count+1), sensorVal: String(format:"%.2f", val), sensorFunc: function, sensorRelay: nil)
                        self.sensorList.append(foobar!)
                    }
                    
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
        return sensorList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "sensorTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SensorTableViewCell
        
        let sensorItem = sensorList[indexPath.row]
        
        sensorList.sortInPlace({ $0.sensorNum < $1.sensorNum })
        
        cell.cell_sensorNum.text = sensorItem.sensorNum
        cell.cell_sensorVal.text = sensorItem.sensorVal
        cell.cell_sensorFunc.text = sensorItem.sensorFunc
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;
        
        return cell
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer1!.invalidate()
        timer2!.invalidate()
    }
}
