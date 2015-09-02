//
//  PhotoDetailViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/6/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class PhotoDetailViewController:UIViewController {
    
    var photo:JSON!
    
    @IBOutlet var photoView: UIImageView!
    
    
    @IBOutlet var captionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.photoView.hnk_setImageFromURL(NSURL(string: photo["images"]["standard_resolution"]["url"].string!)!)
        
        self.captionTextView.text = photo["caption"]["text"].string!
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = false
        
    }
    

}
