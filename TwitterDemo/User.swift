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
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        else {
            profileUrl = NSURL(string: "")
        }
        
        tagline = dictionary["description"] as? String as NSString?
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    static var currentUser: User? {
        get {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? NSData
            
            if let userData = userData {
                if let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as? NSDictionary{
                _currentUser = User(dictionary: dictionary)
                }
                else {
                    _currentUser = nil
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = _currentUser{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }
            else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            //defaults.set(user, forKey: "currentUser")
            
            defaults.synchronize()
        }
    }
}

