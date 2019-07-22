//
//  DescriptionViewCell.swift
//  mercadolibre
//
//  Created by Maximiliano Talenti on 22/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class DescriptionViewCell: UITableViewCell {

    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Update(Desc : String) {
        titleDescription.text = NSLocalizedString("KeyDescription", comment: "")
        labelDescription.text = Desc
    }
}
