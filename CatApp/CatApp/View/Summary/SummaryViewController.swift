//
//  SummaryViewController.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
    }

    func closePopUp() {
        self.removeAnimate()
    }
    
    private func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }

}
