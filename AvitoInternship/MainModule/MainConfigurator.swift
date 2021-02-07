//
//  MainConfigurator.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 09.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import Foundation

class MainConfigurator: MainConfiguratorProtocol {
    let jsonURL = "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"
    
    func configure(with viewController: MainViewController) {
        viewController.showHUD()
        
        viewController.collectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: "MainCollectionViewCell")
        
        viewController.setChooseButtonLabel(with: "")
        viewController.setTitleLabel(with: "")
        
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        viewController.collectionView.dataSource = presenter
        viewController.collectionView.delegate = presenter
        
        interactor.fetchData(from: jsonURL) { res in
            if let res = res {
                presenter.parseData(data: res)
                DispatchQueue.main.async {
                    presenter.configureView()
                    viewController.hideHUD()
                }
            }
        }
    }
}
