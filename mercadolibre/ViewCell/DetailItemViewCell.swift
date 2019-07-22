//
//  DetailItemViewCell.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 21/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class DetailItemViewCell: UITableViewCell {

    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var labelInformation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Update(Imagen : String, Informacion : String) {
        imageDetail.image = UIImage.init(named: Imagen)
        labelInformation.text = Informacion
    }
    
}
