//
//  MainViewController.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 09.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
 

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseButtonOutlet: UIButton!
    
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
        print("close button clicked")
    }
    
    @IBAction func chooseButtonClicked(_ sender: Any) {
        var cell: MainCollectionViewCell?
        if let indexPath = collectionView.indexPathsForSelectedItems?.first  {
            cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
        }
        if let alert = self.presenter?.chooseButtonClicked(selectedCell: cell) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setTitleLabel(with value: String?) {
         titleLabel.text = value
     }
     
     func setChooseButtonLabel(with value: String?) {
        chooseButtonOutlet.setTitle(value, for: .normal)
    }
     func reloadData() {
         collectionView.reloadData()
     }
}
