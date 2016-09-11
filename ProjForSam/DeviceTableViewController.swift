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
    var timer1: NSTimer?
    var timer2: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.multipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
        
        self.tableView.reloadData()
        
        if (counter == 0) {
            timer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(DeviceTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        timer2 = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(DeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)

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
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = index?.row
        
        var deviceSelect = self.deviceList[indexNumber!]

        if (deviceSelect.deviceStat == true) {
            self.performSegueWithIdentifier("relayTableSegue", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please connect your device to view relay status", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        timer1!.invalidate()
        timer2!.invalidate()
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = index?.row
        let relayViewController = segue.destinationViewController as! RelayTableViewController
        
        photonDevice = photonDeviceList[indexNumber!]
        
        var deviceSelect = self.deviceList[indexNumber!]

        relayViewController.title = "Device: " + deviceSelect.deviceName
        relayViewController.photonDevice = photonDevice
        
    }
}