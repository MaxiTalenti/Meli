//
//  SearchResultsViewCell.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 19/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class SearchResultsViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var AdditionalInformation1: UILabel!
    @IBOutlet weak var AdditionalInformation2: UILabel!
    @IBOutlet weak var AdditionalInformation3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func Update(result: Result){
        titleLabel.text = result.title
        priceLabel.text = result.price.description

        self.productImage.downloaded(from: result.thumbnail )
        
        AddAdditionalInformation(result: result)
    }
    
    func AddAdditionalInformation(result: Result){
        UpdateLabels(condition: QuantityCuotes(result: result.installments), changeColor: true)
        UpdateLabels(condition: FreeShipping(result: result.shipping), changeColor: true)
        UpdateLabels(condition: IsUsed(result: result), changeColor: false)
    }
        
    // Verifica cuotas sin interés
    func QuantityCuotes(result : Installments?) -> String {
        if (result == nil) {
            return ""
        }
        if (result?.rate == 0) {
            return "Hasta \(result?.quantity ?? 0) cuotas sin interés"
        }
        else {
            return ""
        }
    }
    
    // Verifica el envío gratis
    func FreeShipping(result : Shipping?) -> String {
        if (result == nil) {
            return ""
        }
        if (result?.freeShipping ?? false) {
            return "Envío gratis"
        }
        else {
            return ""
        }
    }
    
    // Verifica si es usado
    func IsUsed(result: Result) -> String {
        if (result.condition == "used") {
            return "Usado"
        }
        else {
            return ""
        }
    }
    
    func UpdateLabels(condition : String, changeColor : Bool) {
        if (!condition.isEmpty) {
            GetLabelEmpty().text = condition
            if (changeColor) {
                GetLabelEmpty().textColor = UIColor.init(red: 58/255, green: 117/255, blue: 58/255, alpha: 1)
            }
            
            GetLabelEmpty().isHidden = false
        }
    }
    
    func GetLabelEmpty() -> UILabel {
        if (AdditionalInformation1.isHidden) {
            return AdditionalInformation1
        } else if (AdditionalInformation2.isHidden) {
            return AdditionalInformation2
        } else {
            return AdditionalInformation3
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if (error != nil) {
                print(error.debugDescription)
                return
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
