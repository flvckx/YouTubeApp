//
//  YTVideosCell.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/23/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class YTVideosCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setUpCellWithVideos(video video: YTVideo) {
        self.title.text = video.title!
        if (video.url != nil) {
            if let url = NSURL(string: video.url!) {
                self.photo.sd_setImageWithURL(url)
            }
        } else {
            self.photo.image = UIImage(named: "youtube")
        }
    }
    
    func setUpCellWithSearchedVideos(video video: YTSearchedVideo) {
        self.title.text = video.title!
        if (video.url != nil) {
            if let url = NSURL(string: video.url!) {
                self.photo.sd_setImageWithURL(url)
            }
        } else {
            self.photo.image = UIImage(named: "youtube")
        }
    }
}
