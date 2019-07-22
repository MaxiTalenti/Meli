//
//  HeaderItemDetailTableViewCell.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 21/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class HeaderItemDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var StateAndSellers: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Pricing: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Update(_ result : Item?) {
        if (result?.soldQuantity != nil) {
            StateAndSellers.text = "\(result?.condition == "new" ? "Nuevo" : "Usado") - \(result?.soldQuantity?.description ?? "0") vendidos"
        } else {
            StateAndSellers.text = result?.condition == "new" ? "Nuevo" : "Usado"
        }
        Title.text = result?.title
        Pricing.text = result?.price?.description
    }
    
}
