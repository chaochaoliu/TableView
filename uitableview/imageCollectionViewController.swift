//
//  imageCollectionViewController.swift
//  uitableview
//
//  Created by Chao Liu on 8/6/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit

class imageCollectionViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    let threshold:CGFloat = 100.0
    var isLoadingPhotos = false
    var linkToFetch = "https://api.instagram.com/v1/tags/sunset/media/recent?access_token=203251101.1fb234f.451b23a663754f4f9c621f3b6fa989c4"
    
    var nextPageLink = ""
    let networkManager = NetworkManager()
    var photos = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadPhotos { () -> Void in }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! PhotoCell
        
        let photo = self.photos[indexPath.row]
        
        cell.imageView.hnk_setImageFromURL(NSURL(string: photo["images"]["thumbnail"]["url"].string!)!)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout:UICollectionViewLayout!,sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        
        let cellWith = (self.view.frame.size.width - 10)/3
        
        return CGSize(width: cellWith, height: cellWith)
    }
    
    func loadPhotos(completion:() -> Void) {
        if self.isLoadingPhotos == true {
            
            return
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.isLoadingPhotos = true
        
        if nextPageLink != "" {
        
            linkToFetch = nextPageLink
        }
        
        networkManager.manager.request(.GET, linkToFetch, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (request, response, responseJSON, error) in
            
            self.isLoadingPhotos = false
            
            if(error != nil) {
                NSLog("Fetch News Collection Error: \(error)")
                
            }else if responseJSON == nil{
                NSLog("Fetch News Collection Error: \(error)")
            }else{
                let jsonData = JSON(responseJSON!)
                
                for (id,photo) in jsonData["data"] {
                    self.photos.append(photo)
                }
                
                if let nextPage = jsonData["pagination"]["next_url"].string {
                    
                    self.nextPageLink = nextPage
                }
        
                self.collectionView.reloadData()
            }
            
        }

        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        let photo = self.photos[indexPath.row]
        
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PhotoDetailViewController") as! PhotoDetailViewController
        
        destinationViewController.photo = photo
        
        destinationViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - contentOffset <= threshold {
            
            self.loadPhotos ({ () -> Void in })
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photos.count
    }
    
    
}
