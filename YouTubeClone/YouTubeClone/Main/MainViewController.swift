//
//  MainViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var rootPageViewController : RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
