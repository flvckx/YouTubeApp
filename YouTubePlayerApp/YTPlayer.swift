//
//  YTPlayer.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import YouTubePlayer

class YTPlayer: UIViewController {
    @IBOutlet var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var videoTitle: UILabel!
    
    var videoId: String?
    var vTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoTitle.text = self.vTitle
        videoPlayer.loadVideoID(videoId!)
    }
    
    @IBAction func viewIsSwiped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
