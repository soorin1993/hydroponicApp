//
//  SensorDeviceTableViewController.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 9/28/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import UIKit
import ParticleSDK

class SensorDeviceTableViewController: UITableViewController, UITabBarDelegate {

    // MARK: Properties
    var deviceList = [Devices]()
    var sensorDeviceList: [SparkDevice] = []
    var photonDevice: SparkDevice?
    var timer1: NSTimer?
    var timer2: NSTimer?
    var counter = 0
    
    
    @IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("LoginView") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.multipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
        
        self.tableView.separatorColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)
        
        
        self.tableView.reloadData()
        
        if (counter == 0) {
            timer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(SensorDeviceTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        timer2 = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(SensorDeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)
        
        loadDevices()
        self.refreshControl?.addTarget(self, action: #selector(SensorDeviceTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //This method will be called when user changes tab.
        if item.title == "Logout" {
            SparkCloud.sharedInstance().logout()
            let viewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("VC") as! ViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
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
                        
                        
                        if device.name!.rangeOfString("sensor") != nil{
                            
                            print(device)
                            self.sensorDeviceList.append(device)
                            var temp = Devices(deviceName: device.name!, deviceStat: device.connected, deviceVal: "temp", deviceLoc: "soo casa")!
                            
                            self.deviceList.append(temp)
                            
                        }
                    }
                }
            }
        }
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
        let cellIdentifier = "sensorDeviceTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SensorDeviceTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let deviceItem = deviceList[indexPath.row]
        
        cell.cell_deviceID.text = deviceItem.deviceName
        
        var stat: String
        
        if (deviceItem.deviceStat == true) {
            stat = "Connected"
            cell.cell_deviceImg.image = UIImage(named: "connected")
            
        }
        else {
            stat = "Disconnceted"
            cell.cell_deviceImg.image = UIImage(named: "disconnected")
            
        }
        
        cell.cell_deviceStat.text = stat
        cell.cell_deviceVal.text = deviceItem.deviceVal
        cell.cell_deviceLoc.text = deviceItem.deviceLoc
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = index?.row
        
        var deviceSelect = self.deviceList[indexNumber!]
        
        if (deviceSelect.deviceStat == true) {
            self.performSegueWithIdentifier("sensorTableSegue", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please connect your device to view sensor status", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        timer1!.invalidate()
        timer2!.invalidate()
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = index?.row
        let sensorViewController = segue.destinationViewController as! SensorTableViewController
        
        photonDevice = sensorDeviceList[indexNumber!]
        
        var deviceSelect = self.deviceList[indexNumber!]
        
        sensorViewController.title = "Device: " + deviceSelect.deviceName
        print("!!", photonDevice)
        sensorViewController.photonDevice = photonDevice
        
    }


}
