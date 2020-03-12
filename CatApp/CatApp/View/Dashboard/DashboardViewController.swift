//
//  DashboardViewController.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/20/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var breedView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var myVotesView: UIView!
    @IBOutlet weak var voteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customViews()
    }
    
    private func customViews(){
        navigationItem.title = CatDashboardConstant.Title
        customBreedView()
        customFavoriteView()
        customMyVotesView()
    }
    
    private func customBreedView() {
        breedView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openBreedView(tapGestureRecognizer:)))
        breedView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openBreedView(tapGestureRecognizer: UITapGestureRecognizer) {
        openCatList(viewType: .breed)
    }
    
    private func customFavoriteView() {
        favoriteView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openFavoriteView(tapGestureRecognizer:)))
        favoriteView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openFavoriteView(tapGestureRecognizer: UITapGestureRecognizer) {
        openCatList(viewType: .favorite)
    }
    
    private func customMyVotesView() {
        myVotesView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMyVotesView(tapGestureRecognizer:)))
        myVotesView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openMyVotesView(tapGestureRecognizer: UITapGestureRecognizer) {
        openCatList(viewType: .votes)
    }
    
    private func openCatList(viewType: ViewType){
        let catListViewController = CatListViewController()
        catListViewController.viewType = viewType
        self.navigationController?.pushViewController(catListViewController, animated: true)
    }

}
