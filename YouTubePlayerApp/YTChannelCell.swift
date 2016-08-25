//
//  YTChannelCell.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import SDWebImage

class YTChannelCell: UITableViewCell {
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelDescriptionLabel: UILabel!
    
    func setUpCellWithChannels(channel channel:YTChannel) {
        
        self.channelTitleLabel.text = channel.title
        self.channelDescriptionLabel.text = channel.descr
        if (channel.photoUrl != nil) {
            if let url = NSURL(string: channel.photoUrl!) {
                self.channelImageView.sd_setImageWithURL(url)
            }
        } else {
            self.channelImageView.image = UIImage(named: "youtube")
        }
    }
}
