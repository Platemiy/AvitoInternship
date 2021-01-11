//
//  MainProtocols.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 09.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    func setTitleLabel(with value: String?)
    func setChooseButtonLabel(with value: String?)
    func reloadData()
}

protocol MainPresenterProtocol: class, UICollectionViewDataSource, UICollectionViewDelegate {
 
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var options: [Option] { get set }
    var titleText: String  { get set }
    var actionTitle: String { get set }
    var selectedActionTitle: String { get set }
    
    func configureView()
    
    func buttonGotSelected()
    func buttonGotDeselected()
    
    func chooseButtonClicked(selectedCell: MainCollectionViewCell?) -> UIAlertController
}

protocol MainInteractorProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    func fetchData(from url: String)
}


protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}
