//
//  RootPageViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 08/03/2023.
//

import UIKit

protocol RootPageProtocol : AnyObject {
    func currentIndex(index : Int)
}

class RootPageViewController: UIPageViewController {
    
    var subViewControllers = [UIViewController]()
    var currentPage = 0
    weak var rootPageProtocol : RootPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setUpViewControllers()
    }
    
    private func setUpViewControllers(){
        subViewControllers = [
            HomeViewController(),
            VideoViewController(),
            PlaylistViewController(),
            ChannelViewController(),
            AboutViewController()
        ]
        _ = subViewControllers.enumerated().map({ $0.element.view.tag = $0.offset })
        setViewControllerForIndex(index: 0, direction: .forward)
    }
    
    func setViewControllerForIndex(index : Int, direction : NavigationDirection,animation : Bool = true){
        setViewControllers([subViewControllers[index]], direction: direction, animated: animation)
    }
    
}
extension RootPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index : Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if index <= 0 {
            return nil
        }
        
        return subViewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index : Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if index >= (subViewControllers.count-1) {
            return nil
        }
        
        return subViewControllers[index+1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let index : Int = pageViewController.viewControllers?.first?.view.tag {
            currentPage = index
        }
        rootPageProtocol?.currentIndex(index: currentPage)
    }

    
}
