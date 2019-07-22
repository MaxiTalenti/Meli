//
//  ViewController.swift
//  mercadolibre
//
//  Created by Luciano Bolzico on 18/07/2019.
//  Copyright © 2019 Maximiliano Talenti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var resultsTable: UITableView!
    
    var products : Products!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Buscar";
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        self.navigationItem.searchController?.searchBar.placeholder = "iPhone, Mac.."
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        
        self.resultsTable.dataSource = self
        self.resultsTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products != nil{
            return products.results.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (products != nil) {
            let cell = Bundle.main.loadNibNamed("SearchResultsViewCell", owner: self, options: nil)?.first as! SearchResultsViewCell
            cell.Update(result: products.results[indexPath.row])
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("EmptyViewCell", owner: self, options: nil)?.first as! EmptyViewCell
            cell.Update(Info: "Haga una búsqueda", Imagen: "buscar")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.searchController?.isActive = false

        if (products != nil) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        resultViewController.Producto = self.products.results[indexPath.row]
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (products == nil) {
            return self.resultsTable.frame.height
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            print(text)
            //self.filtered = self.countries.filter({ (country) -> Bool in
            //    return country.lowercased().contains(text.lowercased())
            //})
            //self.filterring = true
        }
        else {
            //self.filterring = false
            //self.filtered = [String]()
        }
        //self.table.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(text)")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                if (error == nil)
                {
                    DispatchQueue.main.async {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            self.products = try decoder.decode(Products.self, from: data)
                            self.resultsTable.reloadData()
                            searchBar.endEditing(true)
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
}
