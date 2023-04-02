//
//  PlaylistViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = PlaylistPresenter(delegate: self)
    private var dataObject : [PlayListModel.Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configure(delegate: self, dataSource: self, cells: [PlaylistCell.self], showIndicators: true)
        Task{
            await presenter.getPlaylist()
        }
    }
}

extension PlaylistViewController : UITableViewDelegate , UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataObject.count as Any)
        return dataObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(for: PlaylistCell.self, for: indexPath)
            cell.configCell(model: dataObject[indexPath.row])
            return cell
    }
}

extension PlaylistViewController: PlaylistViewProtocol{
    func getData(list: [PlayListModel.Item]) {
        dataObject = list
        tableView.reloadData()
        print("Video List",list)
    }
}
