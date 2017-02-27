//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/19/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var composeButton: UIButton!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        composeButton.setImage(UIImage(named: "edit-icon"), for: .normal)
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            /*
            for tweet in tweets {
                print(tweet.text!)
            }
            */
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        }
        else {
            return 0
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
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
        
        
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as! TweetDetailsViewController
            
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let tweet = tweets[(indexPath?.row)!]
            vc.tweet = tweet

            let cell = sender as! UITableViewCell
            cell.selectionStyle = .gray
        }
        else if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileViewController
            
            if let button = sender as? UIButton {
                let cell = button.superview?.superview as! UITableViewCell
                let indexPath = tableView.indexPath(for: cell)
                let tweet = tweets[(indexPath?.row)!]
                vc.user = tweet.user
            }
        }
        else if segue.identifier == "composeSegue" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.user = User.currentUser
        }
        else if segue.identifier == "replySegue" {
            let vc = segue.destination as! ComposeTweetViewController
            if let button = sender as? UIButton {
                let cell = button.superview?.superview as! UITableViewCell
                let indexPath = tableView.indexPath(for: cell)
                let tweet = tweets[(indexPath?.row)!]
                vc.user = tweet.user
                vc.replyText = "@" + String(describing: tweet.screenname!)
            }
        }
    }
}
