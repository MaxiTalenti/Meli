//
//  ImagenDetailViewCell.swift
//  mercadolibre
//
//  Created by Maximiliano Talenti on 21/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class ImagenDetailViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func Update(Url : String) {
        if (self.imageCell != nil)
        {
            if (Url.isEmpty) {
                self.imageCell.image = UIImage.init(named: "noImage")
            } else {
                self.imageCell.downloaded(from: Url)
            }
        }
    }

}
