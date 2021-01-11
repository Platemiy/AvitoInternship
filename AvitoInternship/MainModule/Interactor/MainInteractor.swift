//
//  MainInteractor.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 09.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import Foundation
import UIKit

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
    
    
    func fetchData(from url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data,response,error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Stat.self, from: data)
                        if res.status != "ok" {
                            print("data corrupted")
                            return
                        }
                        guard let presenter = self.presenter else { return }
                        presenter.titleText = res.result.title
                        presenter.actionTitle = res.result.actionTitle
                        presenter.selectedActionTitle = res.result.selectedActionTitle
                        presenter.options = res.result.list
                        if presenter.options.count > 0 {
                            for  (index, _) in presenter.options.enumerated() {
                                if let url = URL(string: presenter.options[index].icon.values.first!){
                                    if let data = try? Data(contentsOf: url) {
                                        presenter.options[index].image = data
                                    }
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.presenter?.configureView()
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
