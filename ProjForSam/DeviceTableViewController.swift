//
//  Device.swift
//  ProjForSam
//
//  Created by Soo Rin Park on 8/25/16.
//  Copyright © 2016 Soo Rin Park. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    // MARK: Properties
    var devices = [Devices]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDevices()
    }
    
        
    func loadDevices() {
        
        
        /* Outdated JSON functionality
        let requestURL: NSURL = NSURL(string: "http://creative.colorado.edu/~sopa7126/school/samProj/sample.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(statusCode)
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                }
                catch {
                    print("Error with Json: \(error)")
                }
                
            }
        }
        
        task.resume()
        */
        
        
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
        return devices.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "tableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let deviceItem = devices[indexPath.row]
        
        cell.id.text = meal.name
        cell.id.text = meal.name

        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.ratin
        
        return cell
    }
    


}
