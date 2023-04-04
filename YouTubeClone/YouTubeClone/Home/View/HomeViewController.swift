//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit
import FloatingPanel

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = HomePresenter(delegate: self)
    private var dataObject : [[Any]] = []
    private var dataSectionTitleList : [String] = []
    var fpc: FloatingPanelController?
    var floatingPanelIsPresented : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFloatinPanel()
        tableView.configure(delegate: self,
                            dataSource: self,
                            cells: [
                                ChannelCell.self,
                                PlaylistCell.self,
                                VideoCell.self])
        tableView.registerFromClass(headerFooterView: SectionTitleView.self)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataObject[indexPath.section]
        var videoId : String = ""
        
        if let playlistItem = item as? [PlayListItemModel.Item]{
            videoId = playlistItem[indexPath.row].contentDetails?.videoID ?? ""
            
        }else if let videos = item as? [VideoModel.Item]{
            videoId = videos[indexPath.row].id.videoId ?? ""
        }
        if floatingPanelIsPresented{
            fpc?.willMove(toParent: nil)
            fpc?.hide(animated: true, completion: {[weak self] in
                guard let self = self else {return}
                // Remove the floating panel view from your controller's view.
                self.fpc?.view.removeFromSuperview()
                // Remove the floating panel controller from the controller hierarchy.
                self.fpc?.removeFromParent()
                
                self.dismiss(animated: true, completion: {
                    self.presentViewPanel(videoId)
                })
            })
            return
        }
        presentViewPanel(videoId)
    }
}

extension HomeViewController : FloatingPanelControllerDelegate{
    func presentViewPanel(_ videoId : String){
        let contentVC = PlayVideoViewController()
        contentVC.videoId = videoId
        
        contentVC.goingToBeCollapsed = {[weak self] goingToBeCollapsed in
            guard let self = self else {return}
            if goingToBeCollapsed{
                self.fpc?.move(to: .tip, animated: true)
                NotificationCenter.default.post(name: .viewPosition, object: ["position":"bottom"])
                self.fpc?.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
            }else{
                self.fpc?.move(to: .full, animated: true)
                NotificationCenter.default.post(name: .viewPosition, object: ["position":"top"])
                self.fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
            }
        }
        
        contentVC.isClosedVideo = {[weak self] in
            self?.floatingPanelIsPresented = false
        }
        
        fpc?.set(contentViewController: contentVC)
//        fpc?.track(scrollView: contentVC.tableViewVideos)
        if let fpc = fpc{
            floatingPanelIsPresented = true
            present(fpc, animated: true)
        }
    }
    
    func configFloatinPanel(){
        fpc = FloatingPanelController(delegate: self)
        fpc?.isRemovalInteractionEnabled = true
        fpc?.surfaceView.grabberHandle.isHidden = true
        fpc?.layout = MyFloatingPanelLayout()
        fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
    }
    
    func floatingPanelDidRemove(_ fpc: FloatingPanelController) {
        floatingPanelIsPresented = false
    }
    
    func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .full {
            NotificationCenter.default.post(name: .viewPosition, object: ["position":"bottom"])
            fpc?.surfaceView.contentPadding = .init(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            NotificationCenter.default.post(name: .viewPosition, object: ["position":"top"])
            fpc?.surfaceView.contentPadding = .init(top: -48, left: 0, bottom: -48, right: 0)
        }
    }
}

extension NSNotification.Name{
    static let viewPosition = Notification.Name("viewPosition")
    static let expand = Notification.Name("expand")
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 0.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
