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
    @IBOutlet weak var composeButton: UIButton!
    
    var didRetweet: Bool = false
    var didFavorite: Bool = false
    
    var tweet: Tweet!
    var tweetID: Int = 0
    
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
        
        replyButton.setImage(UIImage(named: "reply-icon") , for: .normal)
        composeButton.setImage(UIImage(named: "edit-icon"), for: .normal)

        tweetID = tweet.tweetID
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoritesCount)
        
        didRetweet = tweet.retweeted
        didFavorite = tweet.favorited
        
        if didRetweet {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        if didFavorite {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    @IBAction func onReply(_ sender: Any) {
        print("reply")
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        
        if didRetweet {
            TwitterClient.sharedInstance?.unretweet(tweetID: tweetID, success: { (tweet: Tweet) in
                self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            tweet.retweetCount -= 1
        }
            
        else {
            TwitterClient.sharedInstance?.retweet(tweetID: tweetID, success: { (tweet: Tweet) in
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            tweet.retweetCount += 1
        }
        self.retweetCountLabel.text = String(tweet.retweetCount)
        tweet.retweeted = !tweet.retweeted
        didRetweet = !didRetweet
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        
        if didFavorite {
            TwitterClient.sharedInstance?.unfavorite(tweetID: tweetID, success: { (tweet: Tweet) in
                self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            tweet.favoritesCount -= 1
        }
            
        else {
            TwitterClient.sharedInstance?.favorite(tweetID: tweetID, success: { (tweet: Tweet) in
                self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)

            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            tweet.favoritesCount += 1
        }
        self.favoriteCountLabel.text = String(tweet.favoritesCount)
        tweet.favorited = !tweet.favorited
        didFavorite = !didFavorite
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
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileViewController
            if (sender as? UIButton) != nil {
                vc.user = tweet.user
            }
        }
        else if segue.identifier == "composeSegue" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.user = User.currentUser
        }
        else if segue.identifier == "replySegue" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.user = User.currentUser
            vc.replyText = "@" + String(describing: tweet.screenname!) + " "
        }
    }

}
