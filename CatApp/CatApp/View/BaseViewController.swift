//
//  BaseViewController.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addActivityIndicator(view : UIView){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{(make) -> () in
            make.center.equalTo(view)
        }
        activityIndicator.isHidden = true
    }
    
    func useActivityIndicator(_ isLoading: Bool){
        DispatchQueue.main.async {
            if isLoading{
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }else{
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showError(_ errorMessage: String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func processUrlImage(_ imageView: UIImageView, _ url: URL?){
        let processor = DownsamplingImageProcessor(size: imageView.intrinsicContentSize) >> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "cat"),
            options: [
                .processor(processor),
                .scaleFactor(0.5),
                .transition(.fade(0.5)),
                .cacheOriginalImage
        ])
        
        imageView.kf.setImage(with: url, placeholder:  UIImage(named: "cat"), options: [
                .processor(processor),
                .scaleFactor(0.5),
                .transition(.fade(0.5)),
                .cacheOriginalImage
        ]) { result in
            switch result {
            case .success(let value):
                
                break
            case .failure(let error):
                break
            }
        }

    }
}
