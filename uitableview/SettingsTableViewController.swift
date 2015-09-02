//
//  SettingsTableViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/2/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "general"
        {
            if let destinationVC = segue.destinationViewController as? ViewController{
                destinationVC.fromPage = "From general cell"
            }
        }
    }

}
