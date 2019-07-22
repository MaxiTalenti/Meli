//
//  ProductServices.swift
//  mercadolibre
//
//  Created by Maximiliano Talenti on 19/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import Foundation

class ProductServices  {

    /*
    func Search(fromText text: String) {
        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(text)")!
        let task = 	URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if (error != nil)
            {
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        let productResult = try decoder.decode(Products.self, from: data)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
    func Search2(text: String) -> Any?{
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(text)") else { return }
        
        let rest = RestManager()
        
        DispatchQueue.global().async { [weak self] in
        
            rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
                if let data = results.data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let productos = try? decoder.decode(Products.self, from: data) else { return }
                    print(productos)
                }
            }
        }
        
        return productos
    }
    */
    
}
