//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)
    private var dataObject : [[Any]] = []
    private var dataSectionTitleList : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        tableView.configure(delegate: self,
                            dataSource: self,
                            cells: [
                                ChannelCell.self,
                                PlaylistCell.self,
                                PlaylistItemCell.self,
                                VideoCell.self])
        
        super.viewDidLoad()
        Task{
            await presenter.getVideosHome()
        }
    }
    

}

extension HomeViewController : HomeViewProtocol {
    func getData(list: [[Any]], sectionTitleList: [String]) {
        
        dataObject = list
        dataSectionTitleList = sectionTitleList
        
        tableView.reloadData()
        
        print(list)
        print(sectionTitleList)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataObject.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataObject[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataObject[indexPath.section]
        
        if let channel = item as? [ChannelModel.Item]{
            let channelCell = tableView.dequeueReusableCell(for: ChannelCell.self, for: indexPath)
//            channelCell.configCell(model: channel[indexPath.row])
            return channelCell
            
        }else if let playlistItems = item as? [PlayListItemModel.Item]{
            let playlistItemsCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
//            playlistItemsCell.configCell(model: playlistItems[indexPath.row])

            return playlistItemsCell
            
        }else if let videos = item as? [VideoModel.Item]{
            let videoCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
//            videoCell.configCell(model: videos[indexPath.row])
            return videoCell
            
        }else if let playlist = item as? [PlayListModel.Item]{
            let playlistCell = tableView.dequeueReusableCell(for: PlaylistCell.self, for: indexPath)
//            playlistCell.configCell(model: playlist[indexPath.row])
            
            return playlistCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSectionTitleList[section]
    }
    
}
