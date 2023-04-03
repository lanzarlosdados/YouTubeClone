//
//  MainViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class MainViewController: BaseViewController {
    
    var rootPageViewController : RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            rootPageViewController = destination
            rootPageViewController.rootPageProtocol = self

        }
    }
}

extension MainViewController : RootPageProtocol {
    func currentIndex(index: Int) {
        print("index", index)
    }
    
    
}
