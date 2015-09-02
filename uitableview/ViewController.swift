//
//  ViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/2/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var textLabel: UILabel!
    
    var fromPage:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textLabel.text = self.fromPage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

