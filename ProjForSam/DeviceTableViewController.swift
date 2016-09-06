//
//  Device.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import Foundation
import UIKit
import ParticleSDK
import Alamofire

var counter = 0

class DeviceTableViewController: UITableViewController {
    
    
    // MARK: Properties
    var deviceList = [Devices]()
    var photonDeviceList: [SparkDevice] = []
    var photonDevice: SparkDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.multipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
        
        self.tableView.reloadData()
        
        if (counter == 0) {
            _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(DeviceTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(DeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)

        loadDevices()
        self.refreshControl?.addTarget(self, action: #selector(DeviceTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

    }

    func update() {
    
        self.tableView.reloadData()
    
    }
    
    func autoUpdate() {
    
        loadDevices()
        self.tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {

        loadDevices()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
        
    func loadDevices() {
        
        deviceList.removeAll()
        
        SparkCloud.sharedInstance().getDevices { (sparkDevices:[AnyObject]?, error:NSError?) -> Void in
            if error != nil {
                print("Check your internet connectivity")
            }
            else {
                if let devices = sparkDevices as? [SparkDevice] {
                    for device in devices {
                        print(device)
                        self.photonDeviceList.append(device)
                        var temp = Devices(deviceName: device.name!, deviceStat: device.connected, deviceVal: "temp", deviceLoc: "soo casa")!
                        self.deviceList.append(temp)
                    }
                }
            }
        }
        //let foo = Devices(deviceName: "...", deviceStat: true, deviceVal: "123", deviceLoc: "??")!
        //self.deviceList.append(foo)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let deviceItem = deviceList[indexPath.row]
        
        cell.cell_deviceID.text = deviceItem.deviceName
        
        var stat: String
        
        if (deviceItem.deviceStat == true) {
            stat = "ON"
            cell.cell_imageView.image = UIImage(named: "awake_dog")

        }
        else {
            stat = "OFF"
            cell.cell_imageView.image = UIImage(named: "sleeping_dog")

        }

        cell.cell_deviceStat.text = stat
        cell.cell_deviceVal.text = deviceItem.deviceVal
        cell.cell_deviceLoc.text = deviceItem.deviceLoc
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("relayTableSegue", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = index?.row
        let vc = segue.destinationViewController as! RelayTableViewController
        
        photonDevice = photonDeviceList[indexNumber!]
        
        var deviceSelect = self.deviceList[indexNumber!]
        
        
        vc.title = "Device: " + deviceSelect.deviceName
        vc.photonDevice = photonDevice
        
        //vc.deviceID = deviceSelect.deviceID
        
    }
}