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
                                VideoCell.self])
        tableView.registerFromClass(headerFooterView: SectionTitleView.self)
        
        super.viewDidLoad()
        Task{
            await presenter.getVideosHome()
        }
    }
    
    func configButtonSheet(){
        let vc = BootomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }

}

extension HomeViewController : HomeViewProtocol {
    func getData(list: [[Any]], sectionTitleList: [String]) {
        
        dataObject = list
        dataSectionTitleList = sectionTitleList
        
        tableView.reloadData()

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
            channelCell.configCell(model: channel[indexPath.row])
            channelCell.moreInformation = {
                let vc = AboutViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return channelCell
            
        }else if let playlistItems = item as? [PlayListItemModel.Item]{
            let playlistItemsCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
            playlistItemsCell.configCell(model: playlistItems[indexPath.row])
            playlistItemsCell.didTapDostsButton = {[weak self] in
                self?.configButtonSheet()
            }
            return playlistItemsCell
            
        }else if let videos = item as? [VideoModel.Item]{
            let videoCell = tableView.dequeueReusableCell(for: VideoCell.self, for: indexPath)
            videoCell.configCell(model: videos[indexPath.row])
            videoCell.didTapDostsButton = {[weak self] in
                self?.configButtonSheet()
            }
            return videoCell
            
        }else if let playlist = item as? [PlayListModel.Item]{
            let playlistCell = tableView.dequeueReusableCell(for: PlaylistCell.self, for: indexPath)
            playlistCell.configCell(model: playlist[indexPath.row])
            playlistCell.didTapDostsButton = {[weak self] in
                self?.configButtonSheet()
            }
            return playlistCell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionTitleView.self)") as? SectionTitleView else{
            return nil
        }
        sectionView.title.text = dataSectionTitleList[section]
        sectionView.configView()
        return sectionView
    }
}
