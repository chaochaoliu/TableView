//
//  SettingNavigationController.swift
//  uitableview
//
//  Created by Chao Liu on 8/7/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class SettingNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.popToRootViewControllerAnimated(animated)
    }
}
