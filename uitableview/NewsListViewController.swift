//
//  NewsListViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/10/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, NewsCellDelegate {

    @IBOutlet var tableView: UITableView!
    
    var news = [Post]()
    let postCollection = PostCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(NewsCellPlain.self, forCellReuseIdentifier: "cellFromCode")
    
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.contentInset = UIEdgeInsetsZero
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadPost()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellFromCode") as! NewsCellPlain
        
        cell.news = self.news[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func  tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? NewsCellPlain {
            return cell.cellHeight
        }
        
        return 114
    }
    
    func loadPost() {
        
        postCollection.fetchData { (posts, error) -> Void in
            for post in posts {
                self.news.append(post)
            }
            self.tableView.reloadData()
        }
    }
    
    func sourceImagTapped(news:Post) -> Void {
    
    }
}
