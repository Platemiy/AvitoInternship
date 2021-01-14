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
    
    
    func fetchData(from url: String, completion: @escaping (Data?)->Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data,response,error in
                if error != nil {
                    completion(nil)
                } else {
                    completion(data)
                }
            }.resume()
        }
    }
}
