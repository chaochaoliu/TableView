//
//  NewsTableViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/2/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke

class NewsTableViewController:UITableViewController, NewsCellDelegate {
    
    var loadingView:UIView!
    var activityIndicator:UIActivityIndicatorView!
    
    var news = [Post]()
    let networkManager = NetworkManager()
    
    let threshold:CGFloat = 100.0
    let postCollection = PostCollection()
    var last_updated:NSDate?
    var isLoadingPosts = false
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.contentInset = UIEdgeInsetsZero
        
        self.refreshControl = UIRefreshControl()
        
        let attributes = [
            NSFontAttributeName:UIFont(name: "Helvetica", size: 12)!
        ]
        
        refreshControl!.attributedTitle = NSAttributedString(string: "Refreshing data...", attributes:attributes)
        
        refreshControl!.addTarget(self, action: "Pull down to reflesh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.tableHeaderView = nil
        self.addIsLoadingView()
    }
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(animated)
        
        self.loadPosts { () -> Void in }
        
        navigationController?.navigationBarHidden = true

    }
    
    func displayAlertMessage(alertTitle:NSString, alertDescription:NSString, style: UIAlertControllerStyle =  UIAlertControllerStyle.Alert) {
        let alertController = UIAlertController(title: alertTitle as String, message: alertDescription as String, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //delegate methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let news = self.news[indexPath.row]
        
        var cell:NewsCellGeneral!
        let hasImage = news.hasImage()
        
      
        
        if hasImage == true
        {
            cell = cellForNewsWithImage()
  
        }else{
            
            cell = cellForNewsWithoutImage()

        }
        
        
        cell.news = news
        cell.delegate = self
        
        return cell
        
    }
    
    func cellForNewsWithImage() -> NewsCellWithImage{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellWithImage") as! NewsCellWithImage!

        return cell
        
    }
    
    func cellForNewsWithoutImage()->NewsCellWithoutImage{
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellWithoutImage") as! NewsCellWithoutImage!
        
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let news = self.news[indexPath.row]
        
        let destViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewsDetailViewController") as! NewsDetailViewController
        
        destViewController.news_id = news.getData("news_id")
        destViewController.news_url = news.getData("original_link")
        
        destViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(destViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sourceImagTapped(news:Post)->Void{
        println(news)
    }
    
    func loadPosts(completion:() -> Void){
        if self.isLoadingPosts == true {
            return
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.isLoadingPosts = true
        
        postCollection.fetchData({
            results, error in
            
            if error != nil{
                self.displayAlertMessage("Error", alertDescription: error!.localizedDescription as NSString)
            }else{
                for post:Post in results{
                    self.news.append(post)
                }
                
                self.tableView!.reloadData()
                
                completion()
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.isLoadingPosts = false
        })
    }
    
    func pullDownToRefresh(refreshControl: UIRefreshControl) {
        
        let attributes = [
            NSFontAttributeName: UIFont(name: "TrebuchetMS-Bold", size: 12)!
        ]
        
        
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl!.refreshing == true {
            self.news.removeAll(keepCapacity: false)
            postCollection.initialLoad = true
            self.loadPosts({ () -> Void in
                self.refreshControl!.endRefreshing()
            })
            
        }
    }
    
   override func scrollViewDidScroll(scrollView: UIScrollView) {
            
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            
            if maximumOffset - contentOffset <= threshold {
                
                if activityIndicator != nil {
                    activityIndicator.startAnimating()
                }
                
                tableView.tableFooterView = loadingView
                self.loadPosts { () -> Void in
                    self.activityIndicator.stopAnimating()
                    self.tableView.tableFooterView  = nil
                }

            }
        }

    func addIsLoadingView() {
        loadingView = UIView(frame: CGRectMake(0, 0, screenWidth, 50))
        //loadingView.backgroundColor = UIColor.lightGrayColor()
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        let activityIndicatorWidth = activityIndicator.frame.size.width
        let activityIndicatorHeight  = activityIndicator.frame.size.height
        
        let loadingLabel = UILabel(frame: CGRectMake(0, 0,200, 50))
        loadingLabel.font = UIFont(name: "Helvetica", size: 13)
        loadingLabel.textColor = UIColor.grayColor()
        loadingLabel.text = "Loading..."
        loadingLabel.numberOfLines = 1
        loadingLabel.sizeToFit()
        
        
        let labelFrame = loadingLabel.frame
        activityIndicator.frame = CGRectMake((screenWidth - activityIndicatorWidth - labelFrame.width - 10 ) / 2, (50 - activityIndicatorHeight) / 2, activityIndicatorWidth, activityIndicatorHeight)
        
        loadingLabel.frame = CGRectMake(activityIndicator.frame.origin.x + activityIndicatorWidth + 10, (50 - activityIndicatorHeight) / 2, labelFrame.width, labelFrame.height)
        
        
        
        loadingView.addSubview(loadingLabel)
        loadingView.addSubview(activityIndicator)
    }

}
