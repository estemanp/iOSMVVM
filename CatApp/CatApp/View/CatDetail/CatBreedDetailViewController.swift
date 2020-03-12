//
//  CatBreedDetailViewController.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit

class CatBreedDetailViewController: BaseViewController {

    @IBOutlet weak var catBreedLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var viewModel : CatBreedDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupViewModel()
        fillData()
    }
    
    @IBAction func goToWikipedia(_ sender: Any) {        
        guard let wikiUrl = viewModel?.catBreed.value.wikipediaUrl , let urlComponents = URLComponents(string: wikiUrl), let url = urlComponents.url else {
            showError(CatDetailConstant.noWiki)
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func vote(_ sender: UIButton) {
        if sender == positiveButton {
            viewModel?.voteCatBreed(inFavor: true)
        }else if sender == negativeButton {
            viewModel?.voteCatBreed(inFavor: false)
        }
    }
    
    @IBAction func changeFavorite(_ sender: Any) {
        viewModel?.changeFavorite()
    }
    
    
    func showSummary() {
        let summaryPopOVerVC: SummaryViewController = SummaryViewController(nibName: "SummaryViewController", bundle: nil)
        self.addChild(summaryPopOVerVC)
        
        summaryPopOVerVC.view.frame = self.view.frame
        self.view.addSubview(summaryPopOVerVC.view)
        summaryPopOVerVC.didMove(toParent: self)
        
        Timer.scheduledTimer(timeInterval: 3, target: BlockOperation(block: {
            summaryPopOVerVC.closePopUp()
            self.dismiss(animated: true, completion: nil)
        }), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    private func setupView(){
        navigationItem.title = CatDetailConstant.Title
        addActivityIndicator(view: self.view)
    }
    
    private func setupViewModel(){
        setupReloadData()
        setupShowSummary()
        setupIsFavorite()
        setupDataLoading()
        setupError()
        viewModel?.fetchImageUrl()
    }
    
    private func setupReloadData(){
        viewModel?.catBreed.bind {[unowned self] _ in
            DispatchQueue.main.async {
                self.fillData()
            }
        }
    }
    
    private func setupShowSummary(){
        viewModel?.showSummary.bind {[unowned self] _ in
            DispatchQueue.main.async {
                self.showSummary()
            }
        }
    }
    
    private func setupIsFavorite(){
        viewModel?.isfavorite.bind {[unowned self] _ in
            DispatchQueue.main.async {
                self.favoriteButton.imageView?.image = UIImage(named: "icHeartFill")
            }
        }
    }
    
    private func setupDataLoading(){
        viewModel?.isDataLoading.bind{[unowned self] isLoading in
            self.useActivityIndicator(isLoading)
        }
    }
    
    private func setupError(){
        viewModel?.error.bind{[unowned self] errorMessage in
            self.showError(errorMessage)
        }
    }
    
    private func fillData(){
        guard let viewModel = viewModel else {
            return
        }
        
        self.catBreedLabel.text = viewModel.catBreed.value.name
        self.descriptionLabel.text = viewModel.catBreed.value.description
        let imageUrl = viewModel.catBreed.value.image?.imageUrl ?? ""
        processUrlImage(self.catImageView, URL(string: imageUrl))
    }
    
}
