//
//  User.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/19/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["name"] as? String as NSString?
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String as NSString?
    }
}
