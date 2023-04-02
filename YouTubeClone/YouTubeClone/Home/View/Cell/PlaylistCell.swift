//
//  PlaylistCell.swift
//  YouTubeClone
//
//  Created by fabian zarate on 21/03/2023.
//

import UIKit
import Kingfisher

class PlaylistCell: UITableViewCell {
    
    @IBOutlet weak var dotsImage: UIButton!
    @IBOutlet weak var videoCountOverlay: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(model : PlayListModel.Item){
        videoTitle.text = model.snippet.title
        videoCount.text = String(model.contentDetails.itemCount)+" videos"
        videoCountOverlay.text = String(model.contentDetails.itemCount)
        
        let imageUrl = model.snippet.thumbnails.medium.url
        if let url = URL(string: imageUrl){
            videoImage.kf.setImage(with: url)
        }
    }
}
