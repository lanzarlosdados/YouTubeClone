//
//  MainViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet  var tabButtons: [UIButton]!

    var rootPageViewController : RootPageViewController!
    private var currentPage = 0 {
        didSet{
            tabButtons[oldValue].tintColor = UIColor(named: "grayColor")
            tabButtons[currentPage].tintColor = .white
        }
    }
    
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
    
    @IBAction func pageSelect(_ sender: UIButton) {
        let index : Int = sender.tag
        var direcction: UIPageViewController.NavigationDirection = .forward
        if index < currentPage{
            direcction = .reverse
        }
        currentPage = index
        rootPageViewController.setViewControllerForIndex(index: index, direction: direcction)
    }

}

extension MainViewController : RootPageProtocol {
    func currentIndex(index: Int) {
        currentPage = index
        print("index", index)
    }
    
    
}
