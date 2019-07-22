//
//  ProductDetailViewController.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 18/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var Producto : Result?
    var ItemDetail : Item?
    var Description: ItemDescription?
    
    var timer = Timer()
    var counter = 0
    
    required init?(item : Result, Detail : Item?) {
        self.Producto = item
        self.ItemDetail = Detail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Producto = nil
        self.ItemDetail = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        self.collectionView.register(UINib(nibName:"ImagenDetailViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagenDetailViewCell")

        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImages), userInfo: nil, repeats: true)
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.tableData.dataSource = self
        self.tableData.delegate = self

        self.searchImages()
        self.getDescription()
    }
    
    // Cambiará la imagen cada vez que el timer se ejecute
    @objc func changeImages() {
        if counter < self.ItemDetail?.pictures.count ?? 0 {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.ItemDetail != nil) {
            // 1 de detalle principal
            // + 1 de ubicación
            // + 1 si tiene cuotas sin interés
            // + 1 si tiene envío gratis
            // + 1 si tiene garantía
            return 1 + CheckQuantity() + FreeShipping() + CheckUbication() + CheckDescription()
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = Bundle.main.loadNibNamed("HeaderItemDetailTableViewCell", owner: self, options: nil)?.first as! HeaderItemDetailTableViewCell
            cell.Update(self.ItemDetail)
            return cell
        }
        let credit = CheckQuantity()
        let shipping = FreeShipping()
        let ubication = CheckUbication()
        
        if (indexPath.row == credit) {
            return GetCredit()
        }
        else if (indexPath.row == (credit + shipping)) {
            return GetDelivery()
        }
        else if (indexPath.row == (credit + shipping + ubication)) {
            return GetUbication()
        }
        else {
            return GetDescription()
        }
    }
    
    func GetCredit() -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailItemViewCell", owner: self, options: nil)?.first as! DetailItemViewCell
        cell.Update(Imagen: "tarjetadecredito", Informacion: "Hasta \(self.Producto?.installments?.quantity ?? 0) cuotas sin interes")
        return cell
    }
    
    func GetDelivery() -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailItemViewCell", owner: self, options: nil)?.first as! DetailItemViewCell
        cell.Update(Imagen: "envio", Informacion: "Envío gratis")
        return cell
    }
    
    func GetUbication() -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailItemViewCell", owner: self, options: nil)?.first as! DetailItemViewCell
        cell.Update(Imagen: "ubicacion", Informacion: self.ItemDetail?.sellerAddress?.state.name ?? "-")
        return cell
    }
    
    func GetDescription() -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DescriptionViewCell", owner: self, options: nil)?.first as! DescriptionViewCell
        cell.Update(Desc: self.Description?.plainText ?? "Sin descripción")
        return cell
    }
    
    // Chequea si tiene cuotas sin interes
    func CheckQuantity() -> Int {
        if (self.Producto?.installments?.rate != nil && self.Producto?.installments?.rate == 0) {
            return 1
        } else {
            return 0
        }
    }
    
    // Chequea si tiene envío gratis
    func FreeShipping() -> Int {
        if (self.Producto?.shipping?.freeShipping ?? false) {
            return 1
        } else {
            return 0
        }
    }
    
    // Chequea si tengo el dato de ubicación
    func CheckUbication() -> Int {
        if (self.ItemDetail?.sellerAddress?.state.name.isEmpty ?? true) {
            return 0
        } else {
            return 1
        }
    }
    
    // Chequea si tiene descripción
    func CheckDescription() -> Int {
        if (self.Description?.plainText?.isEmpty ?? true) {
            return 0
        }
        else {
            return 1
        }
    }
    
    // Busca todas las imágenes
    func searchImages() {
        let url = URL(string: "https://api.mercadolibre.com/items/\(self.Producto?.id ?? "")")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if (error == nil)
            {
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.ItemDetail = try decoder.decode(Item.self, from: data)
                        self.collectionView.reloadData()
                        self.pageControl.numberOfPages = self.ItemDetail?.pictures.count ?? 0
                        self.pageControl.currentPage = 0
                        self.tableData.reloadData()
                    }
                    catch {
                        print(error.localizedDescription)
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    // Busca la descripción del producto
    func getDescription() {
        let url = URL(string: "https://api.mercadolibre.com/items/\(self.Producto?.id ?? "")/description")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if (error == nil)
            {
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.Description = try decoder.decode(ItemDescription.self, from: data)
                        self.collectionView.reloadData()
                        self.pageControl.numberOfPages = self.ItemDetail?.pictures.count ?? 0
                        self.pageControl.currentPage = 0
                        self.tableData.reloadData()
                    }
                    catch {
                        print(error.localizedDescription)
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
}

extension ProductDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagenDetailViewCell", for: indexPath) as! ImagenDetailViewCell
        cell.Update(Url: self.ItemDetail?.pictures[indexPath.row].url ?? "")
        pageControl.currentPage = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.ItemDetail == nil) {
            return 0
        } else {
            return self.ItemDetail?.pictures.count ?? 0
        }
    }
}

extension ProductDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
