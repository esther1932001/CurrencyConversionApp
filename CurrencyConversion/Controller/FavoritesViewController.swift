//
//  FavoritesViewController.swift
//  CurrencyConversion
//
//  Created by esterelzek on 24/08/2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: -Outlets
    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: -Variables
    private var viewModel = ViewModel()
    private var currencies: [CurrencyModelElement] = []//
    var delegate: FavoritesViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomHeader(title: " My Favorites ", table: favTableView)
        favTableView.dataSource = self
        favTableView.delegate = self
        setActivityIndicator()
        fetchFavouritData()
        favTableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
    }
    //MARK: -setActivityIndicator Function
    public func setActivityIndicator() {
        activityIndicator.color = UIColor.black
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 3)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    //MARK: -checkMarkButtonClicked Function
    @objc func checkMarkButtonClicked(sender : UIButton) {
        print("pressed")
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
    }
    //MARK: -fetchFavouritData Function
    private func fetchFavouritData() {
        NetworkManager.shared.request(url: "https://currencyconversion-production-38ba.up.railway.app/currency/", method: .get) { [weak self] (result: Result<[CurrencyModelElement], Error>) in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                self?.favTableView.reloadData()
                DispatchQueue.global().async {
                    Thread.sleep(forTimeInterval: 1)
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                        self?.view.isUserInteractionEnabled = true
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    //MARK: -closeButtom 
    @IBAction func closeButtom(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.setSelectedCurrencies(currencies: self.currencies.filter({$0.isSelected ?? false}))
        }
    }
}
//MARK: -FavoritesViewController Extension
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
        cell.configure(model: currencies[indexPath.row])
        cell.delegete = self
        cell.index = indexPath.row
        return cell
    }
}

extension FavoritesViewController: FavoritesTableViewCellProtocol{
    func setSelection(isSelected: Bool, index: Int) {
        currencies[index].isSelected = isSelected
    }
}

protocol FavoritesViewControllerProtocol {
    func setSelectedCurrencies(currencies: [CurrencyModelElement])
}
