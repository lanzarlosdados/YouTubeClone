//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var presenter = HomePresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension HomeViewController : HomeViewProtocol {
    func getData(list: [[Any]]) {
        print(list)
    }
    
    
}
