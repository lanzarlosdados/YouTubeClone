//
//  BaseViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import UIKit

enum LoadingViewState{
    case show
    case hide
}

protocol BaseViewProtocol{
    func loadingView(_ state : LoadingViewState)
    func showError(_ error : String, callback : (()->Void)?)
}

class BaseViewController: UIViewController {
    var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white

    }
    
    func configNavigationBar(){
        let stackOptions = UIStackView()
        stackOptions.axis = .horizontal
        stackOptions.distribution = .fillEqually
        stackOptions.spacing = 0.0
        stackOptions.translatesAutoresizingMaskIntoConstraints = false
        
        let share = buildButtons(selector: #selector(shareButtonPressed), image: UIImage(named:"cast")!, inset: 30)
        let magnify = buildButtons(selector: #selector(magnifyButtonPressed), image: UIImage(named:"magnifying")!, inset: 33)
        let dots = buildButtons(selector: #selector(dotsButtonPressed), image: UIImage(named:"dots-1")!, inset: 33)
        
        stackOptions.addArrangedSubview(share)
        stackOptions.addArrangedSubview(magnify)
        stackOptions.addArrangedSubview(dots)
        
        stackOptions.widthAnchor.constraint(equalToConstant: 120).isActive = true
        let customItemView = UIBarButtonItem(customView: stackOptions)
        customItemView.tintColor = .clear
        navigationItem.rightBarButtonItem = customItemView
    }

    private func buildButtons(selector : Selector, image : UIImage, inset : CGFloat) -> UIButton{
        let button = UIButton(type: .custom)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }
    
    @objc func shareButtonPressed(){
        print("shareButtonPressed")
    }
    
    @objc func magnifyButtonPressed(){
        print("magnifyButtonPressed")
    }
    
    @objc func dotsButtonPressed(){
        print("dotsButtonPressed")
    }
}

extension BaseViewController{
    func showError(_ error : String, callback : (()->Void)?){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        if let callback = callback{
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                if action.style == .default{
                    callback()
                    print("retry button pressed")
                }
            }))
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            if action.style == .cancel{
                print("ok button pressed")
            }
        }))
        
        present(alert, animated: true)
    }
    
    func loadingView(_ state : LoadingViewState){
        switch state {
        case .show:
            showLoading()
        case .hide:
            hideLoading()
        }
    }
    
    private func showLoading(){
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
    }
    
    private func hideLoading(){
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
