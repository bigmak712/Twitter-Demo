//
//  Tweet Cell.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/20/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var profilePhotoButton: UIButton!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    let minute = Int(60)
    let hour = Int(3600)
    let day = Int(24 * 3600)
    
    var timeDifference: Int = 0
    var timeString: String = ""
    
    var likeCount: Int = 0
    var likeCountString: String = ""
    var didLike = false
    
    var retweetCount: Int = 0
    var retweetCountString: String = ""
    var didRetweet = false
    
    var tweet: Tweet! {
        didSet {
            profileNameLabel.text = tweet.name! as String?
            userNameLabel.text = "@" + (tweet.screenname! as String)
            timestampLabel.text = String(describing: tweet.timestamp!)
            tweetLabel.text = tweet.text! as String?
            
            timeDifference = Int(Date().timeIntervalSince(tweet.timestamp as! Date))
            if timeDifference < minute {
                timeString = String("less that a minute ago")
            }
            else if timeDifference < hour {
                timeDifference = timeDifference/minute
                timeString = String(timeDifference) + "m"
            }
            else if timeDifference < day {
                timeDifference = timeDifference/hour
                timeString = String(timeDifference) + "h"
            }
            else {
                timeDifference = timeDifference/day
                timeString = String(timeDifference) + " days ago"
            }
            
            timestampLabel.text = timeString
            
            // Set reply button image
            let replyImage = UIImage(named: "reply-icon")
            replyButton.setImage(replyImage, for: .normal)
            
            // Set retweet boolean/button image
            if tweet.retweeted == false {
                let retweetImage = UIImage(named: "retweet-icon")
                retweetButton.setImage(retweetImage, for: .normal)
                didRetweet = false
            }
            else {
                let retweetImage = UIImage(named: "retweet-icon-green")
                retweetButton.setImage(retweetImage, for: .normal)
                didRetweet = true
            }
            
            // Set favorited boolean/button image
            if tweet.favorited == false {
                let likeImage = UIImage(named: "favor-icon")
                likeButton.setImage(likeImage, for: .normal)
                didLike = false
            }
            else {
                let likeImage = UIImage(named: "favor-icon-red")
                likeButton.setImage(likeImage, for: .normal)
                didLike = true
            }
            
            likeCount = tweet.favoritesCount
            retweetCount = tweet.retweetCount
            setButtonCountString()
            
            if let photoData = NSData(contentsOf: tweet.profileUrl as! URL) {
                profilePhotoButton.setImage(UIImage(data: photoData as Data), for: .normal)
            }
        }
    }

    @IBAction func retweetButtonTapped(_ sender: Any) {
        if didRetweet {
            retweetCount = retweetCount - 1
        }
        else {
            retweetCount = retweetCount + 1
        }
        didRetweet = !didRetweet
        setButtonCountString()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if didLike{
            likeCount = likeCount - 1
        }
        else {
            likeCount = likeCount + 1
        }
        didLike = !didLike
        setButtonCountString()
    }
    
    func setButtonCountString() {
        if likeCount < 1000 {
            likeCountString = String(likeCount)
        }
        else {
            likeCountString = String((likeCount/1000)) + "K"
        }
            
        likeButton.setTitle(likeCountString, for: .normal)
                        
        if retweetCount < 1000 {
            retweetCountString = String(retweetCount)
        }
        else {
            retweetCountString = String((retweetCount/1000)) + "K"
        }
        retweetButton.setTitle(retweetCountString, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
