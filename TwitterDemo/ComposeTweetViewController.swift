//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Timothy Mak on 2/26/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profilePhotoButton: UIButton!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var sendTweetButton: UIButton!
    
    var replyText: String = ""
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        
        if let photoData = NSData(contentsOf: user.profileUrl as! URL) {
            profilePhotoButton.setImage(UIImage(data: photoData as Data), for: .normal)
        }
        else {
            profilePhotoButton.setImage(UIImage(named: "profile-Icon"), for: .normal)
        }
            
        profileNameLabel.text = String(describing: user.name!)
        userNameLabel.text = "@" + String(describing: user.screenname!)
        tweetTextView.text = replyText
        sendTweetButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if tweetTextView.text.isEmpty {
            sendTweetButton.isEnabled = false
        }
        else {
            sendTweetButton.isEnabled = true
        }
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
        let status = tweetTextView.text!
        
        if segue.identifier == "homeSegue" {
            TwitterClient.sendTweet(status: status, callBack: { (tweet, error) in
                self.tweetTextView.text = ""
                self.tweetTextView.endEditing(true)
            })
        }
    }
}
