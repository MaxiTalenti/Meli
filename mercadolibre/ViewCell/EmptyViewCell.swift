//
//  EmptyViewCell.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 22/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class EmptyViewCell: UITableViewCell {

    @IBOutlet weak var imageDescription: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Update(Info : String, Imagen : String) {
        imageDescription.image = UIImage.init(named: Imagen)
        labelDescription.text = Info
    }
}
