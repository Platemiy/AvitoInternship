//
//  MainCollectionViewCell.swift
//  AvitoInternship
//
//  Created by Artemiy Platonov on 10.01.2021.
//  Copyright © 2021 Artemiy Platonov. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var selectedCheckmark: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-32).isActive = true
    }

    func configure(image: UIImage, title: String, description: String, price: String){
        
        self.iconImage.image = image
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.priceLabel.text = price
    }
    
    func showIcon() {
        self.selectedCheckmark.isHidden = false
    }
    
    func hideIcon() {
        self.selectedCheckmark.isHidden = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
}
