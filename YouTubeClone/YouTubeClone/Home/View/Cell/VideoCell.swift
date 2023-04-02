//
//  VideoCell.swift
//  YouTubeClone
//
//  Created by fabian zarate on 21/03/2023.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var dotsImage: UIButton!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(model : Any){
        
        if let video = model as? VideoModel.Item{
            if let imageUrl = video.snippet.thumbnails.medium.url, let url = URL(string: imageUrl){
                videoImage.kf.setImage(with: url)
            }
            videoName.text = video.snippet.title
            channelName.text = video.snippet.channelTitle
            
            viewsCountLabel.text = "\(video.statistics?.viewCount ?? "0" ) views · 3 months ago"
            
            
            
        }else if let playlistItems = model as? PlayListItemModel.Item { // Playlist Items
            if let imageUrl = playlistItems.snippet.thumbnails.medium.url, let url = URL(string: imageUrl){
                videoImage.kf.setImage(with: url)
            }
            videoName.text = playlistItems.snippet.title
            channelName.text = playlistItems.snippet.channelTitle
            
            viewsCountLabel.text = "332 views · 3 months ago"
            
            
        }
        
    }
    
}
