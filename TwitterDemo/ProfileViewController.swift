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
    @IBOutlet weak var composeButton: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user.backgroundUrl != NSURL(string: "") {
            coverImageView.setImageWith(user.backgroundUrl as! URL)
        }
        if user.profileUrl != NSURL(string: "") {
            profileImageView.setImageWith(user.profileUrl as! URL)
        }
        
        profileNameLabel.text = String(describing: user.name!)
        userNameLabel.text = "@" + String(describing: user.screenname!)
        tweetsCountLabel.text = String(user.tweetsCount)
        followingCountLabel.text = String(user.followingCount)
        followersCountLabel.text = String(user.followersCount)
        composeButton.setImage(UIImage(named: "edit-icon"), for: .normal)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.user = User.currentUser
        }
    }
}
