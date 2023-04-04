//
//  PlayVideoViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 03/04/2023.
//

import UIKit
import youtube_ios_player_helper

final class PlayVideoViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var player: YTPlayerView!
    
    @IBOutlet weak var viewComment: UIView!
    lazy var presenter = VideoPresenter(delegate: self)
    private var dataObject : [Any] = []

    var videoId = ""
    var goingToBeCollapsed : ((Bool)->Void)?
    var isClosedVideo : (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComment.layer.cornerRadius = 12
        imageProfile.layer.cornerRadius = imageProfile.frame.height/2
        configPlayerView()
        tableView.configure(delegate: self, dataSource: self, cells: [VideoCell.self], showIndicators: true)
        Task{
            await presenter.getVideos()
        }
    }
    
    func configPlayerView(){
        let playerVars : [AnyHashable : Any] = ["playsinline":1, "controls":1, "autohide": 1, "showinfo": 0, "modestbranding":0]
        
        player.load(withVideoId: videoId, playerVars: playerVars)
        player.delegate = self
    }

}
extension PlayVideoViewController : YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}

extension PlayVideoViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataObject.count as Any)
        return dataObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
        videoCell.configCell(model: dataObject[indexPath.row])
        return videoCell
    }
}

extension PlayVideoViewController : VideoViewProtocol{
    func getData(list: [Any]) {
        dataObject = list
        tableView.reloadData()
        print("Video List",list)
    }
}
