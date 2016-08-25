//
//  YTPlaylistCell.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/22/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import SDWebImage

class YTPlaylistCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemsCount: UILabel!
    
    func setUpCellWithPlaylists(playlist playlist:YTPlaylist) {
        
        self.title.text = playlist.title!
        if let _ = playlist.itemCount {
            if playlist.itemCount == 1 {
                self.itemsCount.text = String(playlist.itemCount!) + " video"
            } else {
                self.itemsCount.text = String(playlist.itemCount!) + " videos"
            }
        }
        if (playlist.url != nil) {
            if let url = NSURL(string: playlist.url!) {
                self.photo.sd_setImageWithURL(url)
            }
        } else {
            self.photo.image = UIImage(named: "youtube")
        }
    }
}
