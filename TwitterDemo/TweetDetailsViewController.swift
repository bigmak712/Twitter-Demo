//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/20/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileNameLabel.text = tweet.name as String!
        userNameLabel.text = "@" + String(tweet.screenname!)
        descriptionLabel.text = tweet.text as String!
        
        if let photoData = NSData(contentsOf: tweet.profileUrl as! URL) {
            photoButton.setImage(UIImage(data: photoData as Data), for: .normal)
        }
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let timestamp = formatter.string(from: tweet.timestamp as! Date)
        timestampLabel.text = String(timestamp)

        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoritesCount)
        
        replyButton.setImage(UIImage(named: "reply-icon") , for: .normal)
        retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        
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
        
    }

}
