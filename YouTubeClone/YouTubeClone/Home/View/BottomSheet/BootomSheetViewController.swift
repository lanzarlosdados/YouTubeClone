//
//  BootomSheetViewController.swift
//  YouTubeClone
//
//  Created by fabian zarate on 02/04/2023.
//

import UIKit

final class BootomSheetViewController: UIViewController {

    @IBOutlet weak var optionContainer: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionContainer.layer.cornerRadius = 12
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionContainer.animateBottomSheet(show: true){}
    }

    
    @objc func didTapOverlay(_ sender : UITapGestureRecognizer){
        optionContainer.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
}
