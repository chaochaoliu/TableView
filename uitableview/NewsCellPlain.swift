//
//  NewsCellPlain.swift
//  uitableview
//
//  Created by Chao Liu on 8/18/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit


class NewsCellPlain: UITableViewCell {
    
    var delegate: NewsCellDelegate?
    
    var newsTitle:UILabel!
    var newsImage:UIImageView?
    var summary:UILabel!
    var sourceIcon:UIButton?
    var sourceName:UIButton!
    
    var positionX:CGFloat = 10
    var positionY:CGFloat = 10
    let imageWidth:CGFloat = 80
    let imageHeight:CGFloat = 80
    let sourceIconWidth:CGFloat = 20
    let sourceIconHeight:CGFloat = 20
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    var cellHeight:CGFloat = 114
    
    
    var news:Post! {
        didSet{
            
            self.newsDidSet()
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        newsTitle = UILabel(frame: CGRectZero)
        newsTitle.numberOfLines = 3
        
        newsImage = UIImageView(frame: CGRectZero)
        summary = UILabel(frame: CGRectZero)
        sourceIcon = UIButton(frame: CGRectZero)
        sourceName = UIButton(frame: CGRectZero)
        
        self.addSubview(newsTitle)
        self.addSubview(newsImage!)
        self.addSubview(summary)
        self.addSubview(sourceName)
        self.addSubview(sourceIcon!)
        
    }
    
    override func prepareForReuse() {
        positionX = 10
        positionY = 10
        newsTitle.frame = CGRectZero
        newsImage?.frame = CGRectZero
        summary.frame = CGRectZero
        sourceIcon?.frame = CGRectZero
        sourceName.frame = CGRectZero
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newsDidSet(){
        if news.hasImage() == true{
            newsImage?.frame = CGRectMake(positionX, positionY, imageWidth, imageHeight)
            newsImage!.hnk_setImageFromURL(NSURL(string: news.getData("image"))!)
            
            newsImage?.contentMode = UIViewContentMode.ScaleAspectFill
            newsImage!.clipsToBounds = true
            
            positionX = positionX + imageWidth + 10
            
            
        }
        
        newsTitle.frame = CGRectMake(positionX, positionY, screenWidth - positionX - 10, 20)
        newsTitle.text = news.title()
        newsTitle.sizeToFit()
        
        if news.hasImage() == true{
            positionY = 10 + imageHeight - sourceIconHeight
        }else{
            positionY = positionY + newsTitle.frame.size.height + 10
            
            summary.frame = CGRectMake(positionX, positionY, screenWidth - 20, 40)
            summary.sizeToFit()
            summary.numberOfLines = 3
            summary.clipsToBounds = true
            
            positionY = positionY + summary.frame.size.height + 10
        }
        
        if news.hasImage() == true {
            cellHeight = imageHeight + 10
        }
        self.clipsToBounds = true
        
    }
}
