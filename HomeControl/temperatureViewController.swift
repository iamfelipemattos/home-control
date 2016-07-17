//
//  temperatureViewController.swift
//  HomeControl
//
//  Created by Felipe Mattos at Venturus4Tech course.
//

import Foundation
import UIKit

class temperatureTableViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    var temperatureList = [String]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperatureList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tempCell", forIndexPath: indexPath)
        cell.textLabel?.text = temperatureList[indexPath.row]
        return cell
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
