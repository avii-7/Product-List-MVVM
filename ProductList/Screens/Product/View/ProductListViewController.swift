//
//  ProductListViewController.swift
//  ProductList
//
//  Created by Arun on 16/09/23.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    let viewModel = ProductViewModel()
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction func DidAddProductTapped() {
        viewModel.addProduct(product: .init(title: "Pencil"))
    }
}

extension ProductListViewController {
    
    func configuration() {
        configViews()
        attachEvents()
        fetchProducts()
    }
    
    func configViews() {
        configTableView()
    }
    
    func configTableView() {
        tableView.isHidden = true
        tableView.alpha = 0
        tableView.register(
            UINib(nibName: ProductTableViewCell.Identifier, bundle: nil),
            forCellReuseIdentifier: ProductTableViewCell.Identifier
        )
        tableView.sectionHeaderTopPadding = 0
    }
    
    func attachEvents() {
        viewModel.eventHandler = { [weak self] eventType in
            
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch eventType {
                case .dataFetchingStarted:
                    self.activityIndicatorView.startAnimating()
                case .dataFetchingFinished:
                    self.activityIndicatorView.stopAnimating()
                case .dataLoaded:
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    UIView.animate(withDuration: 0.5) {
                        self.tableView.alpha = 1
                    }
                case .dataFetchingFailed(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchProducts() {
        viewModel.fetchProducts()
    }
}

extension ProductListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.Identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.config(model: viewModel.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
