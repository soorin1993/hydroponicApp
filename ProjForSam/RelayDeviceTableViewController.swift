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
//import Alamofire


class RelayDeviceTableViewController: UITableViewController, UITabBarDelegate {
    
    
    // MARK: Properties
    var deviceList = [Devices]() //device class object
    var relayDeviceList: [SparkDevice] = [] //spark device listfor next view controller
    var photonDevice: SparkDevice?
    var timer1: Timer?
    var timer2: Timer?
    var counter = 0

        
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {

        let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! ViewController
        self.present(vc, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isMultipleTouchEnabled = false;
        self.tableView.allowsSelection = true;
        
        self.tableView.separatorColor = UIColor(red: 188/255, green: 226/255, blue: 127/255, alpha:1)

        
        self.tableView.reloadData()
        
        if (counter == 0) {
            timer1 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(RelayDeviceTableViewController.update), userInfo: nil, repeats: true)
            counter += 1
        }
        
        timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(RelayDeviceTableViewController.autoUpdate), userInfo: nil, repeats: true)

        loadDevices()
        self.refreshControl?.addTarget(self, action: #selector(RelayDeviceTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)

    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        if item.title == "Logout" {
            SparkCloud.sharedInstance().logout()
            let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "VC") as! ViewController
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }

    func update() {
        self.tableView.reloadData()
    }
    
    func autoUpdate() {
    
        loadDevices()
        self.tableView.reloadData()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {

        loadDevices()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
        
    func loadDevices() {
        
        deviceList.removeAll()
        
        SparkCloud.sharedInstance().getDevices { (sparkDevices:[Any]?, error:Error?) -> Void in
            if error != nil {
                print("Check your internet connectivity")
            }
            else {
                if let devices = sparkDevices as? [SparkDevice] {
                    for device in devices {
                        
                        if device.name!.range(of: "relay") != nil{
                            
                            print(device)
                            self.relayDeviceList.append(device)
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "relayDeviceTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RelayDeviceTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let deviceItem = deviceList[(indexPath as NSIndexPath).row]
        
        cell.cell_deviceID.text = deviceItem.deviceName
        
        var stat: String
        
        if (deviceItem.deviceStat == true) {
            stat = "Connected"
            cell.cell_imageView.image = UIImage(named: "connected")

        }
        else {
            stat = "Disconnceted"
            cell.cell_imageView.image = UIImage(named: "disconnected")

        }

        cell.cell_deviceStat.text = stat
        cell.cell_deviceVal.text = deviceItem.deviceVal
        cell.cell_deviceLoc.text = deviceItem.deviceLoc
        
        cell.selectionStyle = UITableViewCellSelectionStyle.gray;
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = (index as NSIndexPath?)?.row
        
        let deviceSelect = self.deviceList[indexNumber!]

        if (deviceSelect.deviceStat == true) {
            self.performSegue(withIdentifier: "relayTableSegue", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please connect your device to view relay status", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        timer1!.invalidate()
        timer2!.invalidate()
        
        let index = self.tableView.indexPathForSelectedRow
        let indexNumber = (index as NSIndexPath?)?.row
        let relayViewController = segue.destination as! RelayTableViewController
        
        photonDevice = relayDeviceList[indexNumber!]
        
        let deviceSelect = self.deviceList[indexNumber!]

        relayViewController.title = "Device: " + deviceSelect.deviceName
        relayViewController.photonDevice = photonDevice
        
    }
}
