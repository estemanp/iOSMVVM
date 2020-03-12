//
//  CatListViewController.swift
//  CatApp
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import UIKit
import SnapKit


class CatListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Mark: Public vars
    var viewType: ViewType = .breed
    
    //Mark: Private vars
    private var breedTableView: UITableView = UITableView()
    private var catListDataSource:[CatBreedDetailCell] = []
    private var viewModel: CatBreedListViewModelProtocol = CatBreedListViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSelected()
        setupViewModel()
    }
    
    private func setupView(){
        self.view.backgroundColor = UColor.colorPrimary
        
        navigationItem.title = viewType.title
        let refreshButton = UIBarButtonItem(title: CatListConstant.BarItem.refresh, style: .plain, target: self, action: #selector(refresh(sender:)))
        navigationItem.setRightBarButton(refreshButton, animated: false)
        
        view.addSubview(breedTableView)
        breedTableView.snp.makeConstraints{(make) -> () in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            } else {
                make.edges.equalTo(view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            }
        }
        breedTableView.dataSource = self
        breedTableView.delegate = self
        breedTableView.register(CatTableViewCell.self, forCellReuseIdentifier: CatListConstant.Cell.Identifier)
        
        addActivityIndicator(view: breedTableView)
    }
    
    private func setupViewModel(){
        setupReloadData()
        setupDataLoading()
        setupError()
        initData()
    }
    
        
    private func initData(){
        viewModel.fetchCatBreedList(viewType: viewType)
    }
    
    private func setupReloadData(){
        viewModel.sizeCats.bind {[unowned self] _ in
            DispatchQueue.main.async {
                self.breedTableView.reloadData()
            }
        }
    }
    
    private func setupDataLoading(){
        viewModel.isDataLoading.bind{[unowned self] isLoading in
            self.useActivityIndicator(isLoading)
        }
    }
    
    private func setupError(){
        viewModel.error.bind{[unowned self] errorMessage in
            self.showError(errorMessage)
        }
    }
    
    private func setupSelected(){
        if viewType == .breed {
            breedTableView.allowsSelection = true
        }else{
            breedTableView.allowsSelection = false
        }
    }
    
    
    @objc func refresh(sender:UIBarButtonItem) {
        viewModel.refreshCatBreedList(viewType: viewType)
    }
    
    //MARK: Tableview DataSource and Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sizeCats.value
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CatListConstant.Cell.Identifier, for: indexPath) as! CatTableViewCell
        
        let catCellDetail = viewType == .breed ? viewModel.getCellCatBreedDetail(atIndex: indexPath) : viewType == .favorite ? viewModel.getCellFavoriteDetail(atIndex: indexPath): viewModel.getCellVoteDetail(atIndex: indexPath)
        cell.catBreedLabel.text = catCellDetail.name
        cell.catImageView.obtenerImagenDeUrl(url: catCellDetail.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catBreedDetail = viewModel.getSelectedCatBreedDetail(atIndex: indexPath)
        let catBreedDetailVC: CatBreedDetailViewController = CatBreedDetailViewController(nibName: "CatBreedDetailViewController", bundle: nil)
        catBreedDetailVC.viewModel = CatBreedDetailViewModel(catBreed: catBreedDetail)
        self.navigationController?.pushViewController(catBreedDetailVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == breedTableView{
            if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height{
                viewModel.fetchMoreCatBreed(viewType: viewType)
            }
        }
    }
    
}
