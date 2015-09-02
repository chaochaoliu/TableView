//
//  NewsCellGeneral.swift
//  uitableview
//
//  Created by Chao Liu on 8/4/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import UIKit
import Haneke

protocol NewsCellDelegate{
    
    func sourceImagTapped(news:Post) -> Void
    
}

class NewsCellGeneral: UITableViewCell {
    
    var delegate: NewsCellDelegate?
    var news:Post! {
        didSet{
            
         self.newsDidSet()
            
       }
    }
    
    func newsDidSet(){
        
    }
}