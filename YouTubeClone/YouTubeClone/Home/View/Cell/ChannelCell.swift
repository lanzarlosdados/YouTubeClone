//
//  ChannelCell.swift
//  YouTubeClone
//
//  Created by fabian zarate on 21/03/2023.
//

import UIKit
import Kingfisher

class ChannelCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var moreInformationButton: UIButton!
    @IBOutlet weak var videosCount: UILabel!
    @IBOutlet weak var channelInfoLabel: UILabel!
    @IBOutlet weak var subscriberNumbersLabel: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var moreInformation: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    func configCell(model : ChannelModel.Item){
        channelInfoLabel.text = model.snippet.description
        channelTitle.text = model.snippet.title
        subscriberNumbersLabel.text = "\(model.statistics.subscriberCount ) subscribers"
        videosCount.text = "\(model.statistics.videoCount ) videos"
        
        if let bannerUrl = model.brandingSettings.image.bannerExternalURL, let url = URL(string: bannerUrl){
            bannerImage.kf.setImage(with: url)
        }
        
        let imageUrl = model.snippet.thumbnails.medium.url
        
        guard let url = URL(string: imageUrl) else{
            return
        }
        profileImage.kf.setImage(with: url)
        
    }
    
    @IBAction func moreINformationAction(_ sender: Any) {
        print("tap channel")
        moreInformation?()
        
    }
}
