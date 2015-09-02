//
//  NewsDetailViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/3/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var news_id:String!
    var news_url:String!
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let URL = NSURL(string: news_url){
            let request = NSURLRequest(URL: URL)
            self.webView.loadRequest(request)
            self.webView.scalesPageToFit = true
        }
        
        navigationController?.navigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
