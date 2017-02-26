//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/20/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tweet.user != nil {
            print("user is not nil")
        }
        else {
            print("user is nil")
        }
        
        user = tweet.user
        
        if user.backgroundUrl != NSURL(string: "") {
            coverImageView.setImageWith(user.backgroundUrl as! URL)
        }
        if user.profileUrl != NSURL(string: "") {
            profileImageView.setImageWith(user.profileUrl as! URL)
        }
        
        profileNameLabel.text = user.name as String?
        userNameLabel.text = user.screenname as String?
        tweetsCountLabel.text = String(user.tweetsCount)
        followingCountLabel.text = String(user.followingCount)
        followersCountLabel.text = String(user.followersCount)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
