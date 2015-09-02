//
//  MyTabBarController.swift
//  uitableview
//
//  Created by Chao Liu on 8/6/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    //tab bar color
    override func viewDidLoad() {
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor.redColor()
    
    //tab text attributes
        let attribute = [
            NSFontAttributeName: UIFont(name: "TrebuchetMS-Bold", size: 12)!,
            NSForegroundColorAttributeName: UIColor.greenColor()
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attribute, forState: .Normal)
        
        //selected item text color
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Selected)
        
        var i = 0
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithRenderingMode(.AlwaysOriginal)
                item.selectedImage = image
            }
            item.setTitlePositionAdjustment(UIOffsetMake(0, -2.0))
        }
        
        
        
    }

}
