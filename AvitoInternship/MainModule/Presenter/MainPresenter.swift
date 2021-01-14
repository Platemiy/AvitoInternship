//
//  MainPresenter.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 09.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: NSObject, MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?

    var options = [Option]()
    
    var titleText: String = ""
    var actionTitle: String = ""
    var selectedActionTitle: String = ""

    
    func configureView() {
        view?.setTitleLabel(with: titleText)
        view?.setChooseButtonLabel(with: actionTitle)
        view?.reloadData()
    }
    
    func parseData(data: Data) {
        do {
            let res = try JSONDecoder().decode(Stat.self, from: data)
            if res.status != "ok" {
                print("data corrupted")
                return
            }
            self.titleText = res.result.title
            self.actionTitle = res.result.actionTitle
            self.selectedActionTitle = res.result.selectedActionTitle
            self.options = res.result.list
           // downloading images
            if self.options.count > 0 {
                for  (index, _) in self.options.enumerated() {
                    if let url = URL(string: self.options[index].icon.values.first!){
                        if let data = try? Data(contentsOf: url) {
                            self.options[index].image = data
                        }
                    }
                }
            }
        } catch  {
            print("data is not compatible")
        }
    }
    

    func buttonGotSelected() {
        view?.setChooseButtonLabel(with: selectedActionTitle)
    }
    
    func buttonGotDeselected() {
        view?.setChooseButtonLabel(with: actionTitle)
    }
    
    func chooseButtonClicked(selectedCell: MainCollectionViewCell?) -> UIAlertController {
        var titleText: String? = "Продолжить без изменений"
        var messageText: String? = ""
        if let selectedCell = selectedCell {
            titleText = selectedCell.titleLabel.text
            messageText = selectedCell.descriptionLabel.text
        }
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}

extension MainPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.options.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell

        var image: UIImage?
        if let data = self.options[indexPath.item].image {
              image = UIImage(data: data)
          }
          
        cell.configure(image: image ?? UIImage(named: "checkmark")!, title: self.options[indexPath.item].title , description: self.options[indexPath.item].description ?? "", price: self.options[indexPath.item].price )
          if cell.isSelected {
              cell.showIcon()
          } else {
              cell.hideIcon()
          }
          
          return cell
      }
}

extension MainPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
            cell.showIcon()
            self.buttonGotSelected()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
            if cell.isSelected {
                collectionView.deselectItem(at: indexPath, animated: true)
                cell.hideIcon()
                self.buttonGotDeselected()
                return false
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell {
            cell.hideIcon()
        }
    }
}


