//
//  VideoViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

final class VideoViewController: UIViewController{
 
    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = VideoPresenter(delegate: self)
    private var dataObject : [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configure(delegate: self, dataSource: self, cells: [VideoCell.self], showIndicators: true)
        Task{
            await presenter.getVideos()
        }
    }
}

extension VideoViewController : UITableViewDelegate , UITableViewDataSource {
    

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

extension VideoViewController: VideoViewProtocol{
    func getData(list: [Any]) {
        dataObject = list
        tableView.reloadData()
        print("Video List",list)
    }
}
