//
//  NetworkManager.swift
//  landing
//
//  Created by Chao Liu on 7/29/15.
//  Copyright (c) 2015 OIT. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    var manager: Manager!
    
    init() {
        var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["Accept"] = "application/json"
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
        manager = Alamofire.Manager.sharedInstance
    }
}
