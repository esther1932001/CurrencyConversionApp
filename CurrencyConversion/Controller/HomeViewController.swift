//
//  HomeViewController.swift
//  CurrencyConversion
//
//  Created by esterelzek on 22/08/2023.
//

import UIKit
import DropDown
import Kingfisher
import IQKeyboardManager

//MARK: -Home class
class HomeViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var segmentControllerView: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var convertAmountTextField: UITextField!//
    @IBOutlet weak var fromCurrencyView: UIView! //from dropDown
    @IBOutlet weak var fromCurrencyImageView: UIImageView!
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var amountCurrencyView: UIView!// to dropDown
    @IBOutlet weak var toCurrencyImageView: UIImageView!
    @IBOutlet weak var toCurrencyLable: UILabel!
    @IBOutlet weak var amountCurrencyTextField: UITextField!//
    @IBOutlet weak var convertButton: UIButton!//
    @IBOutlet weak var addToFavoriteVytton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var compareStackView: UIStackView!
    @IBOutlet weak var firstTargetedCurrency: UIView!//first Target DropDown
    @IBOutlet weak var firstTargetImage: UIImageView!
    @IBOutlet weak var firstTargetLable: UILabel!
    @IBOutlet weak var secondTargetedCurrency: UIView!//second Target DropDown
    @IBOutlet weak var secondTargetImage: UIImageView!
    @IBOutlet weak var secondTargetLable: UILabel!
    @IBOutlet weak var firstComparedCurrency: UITextField!//
    @IBOutlet weak var secondComparedCurrency: UITextField!//
    @IBOutlet weak var convertedStackView: UIStackView!
    
    //MARK: -Set dropDown to each view
    var fromDropDown = DropDown()
    var toDropDown = DropDown()
    var firstTargetDropDown = DropDown()
    var secondTargetDropDown = DropDown()
    
    //MARK: -Varibles
    var arrayOfCurrancies:[String] = []
    var selectedIndex: Int?
    var favoriteCurrencies: [CurrencyModelElement] = []
    private var viewModel = ViewModel()
    private var state: CurrencyState = .convert
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setHandleDropDown()
        listenToConvertData()
        listenToCompareData()
    }
    
    //MARK: -Function Set HandleDropDown
    private func setHandleDropDown() {
        handelDropDown(dropDown: fromDropDown, view: fromCurrencyView, lable: fromCurrencyLabel, image: fromCurrencyImageView)// from dropdown
        
        handelDropDown(dropDown: toDropDown, view: amountCurrencyView, lable: toCurrencyLable, image: toCurrencyImageView)// to dropdown
        
        handelDropDown(dropDown: firstTargetDropDown, view: firstTargetedCurrency, lable: firstTargetLable, image: firstTargetImage)// first target dropdown
        
        handelDropDown(dropDown: secondTargetDropDown, view: secondTargetedCurrency, lable: secondTargetLable, image: secondTargetImage)// second target dropdown
        handleTapGestureFromCurrency()
        handleTapGestureToCurrency()
        handleTapGestureFirstTargetCurrency()
        handleTapGestureSecondTargetCurrency()
    }
    
    //MARK: -Function Handel DropDown
    func handelDropDown(dropDown: DropDown, view: UIView,lable: UILabel ,image: UIImageView) {
        dropDown.anchorView = view
        dropDown.bottomOffset = CGPoint(x: 0, y: (fromDropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y: -(fromDropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = {(index: Int, item: String) in
            lable.text = self.arrayOfCurrancies[index]
            image.kf.setImage(with: URL(string:self.favoriteCurrencies[index].imageURL ))
            lable.textColor = .black
            self.selectedIndex = index
        }
    }
    
    //MARK: -Function handleTapGestureFromCurrency
    func handleTapGestureFromCurrency(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTappedOfFromCurrency))
        fromCurrencyView.addGestureRecognizer(tapGesture)
    }
    
    func handleTapGestureToCurrency() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTappedOfToCurrency))
        amountCurrencyView.addGestureRecognizer(tapGesture)
    }
    
    func handleTapGestureFirstTargetCurrency() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTappedOfFirstTargeCurrency))
        firstTargetedCurrency.addGestureRecognizer(tapGesture)
    }
    
    func handleTapGestureSecondTargetCurrency() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTappedOfSecondTargetCurrency))
        secondTargetedCurrency.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTappedOfFromCurrency() {
        fromDropDown.show()
        }
 
    @objc func viewTappedOfToCurrency() {
        toDropDown.show()
        }
    
    @objc func viewTappedOfFirstTargeCurrency() {
        firstTargetDropDown.show()
        }
    
    @objc func viewTappedOfSecondTargetCurrency() {
        secondTargetDropDown.show()
        }
    
    //MARK: -setup Function
    private func setup(){
        viewModel.fetchCurrencyData()
        fetchCurrencyDataForDropDown(dropDown: fromDropDown)
        fetchCurrencyDataForDropDown(dropDown: toDropDown)
        fetchCurrencyDataForDropDown(dropDown: firstTargetDropDown)
        fetchCurrencyDataForDropDown(dropDown: secondTargetDropDown)
        setupUI()
    }
   
    //MARK: -setupUI Function
    private func setupUI(){
        setupCornerRadius(view: segmentControllerView, raduis: 23.0, shouldAddBorder: false)
        setupCornerRadius(view: convertAmountTextField, raduis: 20.0)
        setupCornerRadius(view: fromCurrencyView, raduis: 20.0)
        setupCornerRadius(view: amountCurrencyView, raduis: 20.0)
        setupCornerRadius(view: amountCurrencyTextField, raduis: 20.0)
        setupCornerRadius(view: convertButton, raduis: 20.0)
        setupCornerRadius(view: firstTargetedCurrency, raduis: 20.0)
        setupCornerRadius(view: secondTargetedCurrency, raduis: 20.0)
        setupCornerRadius(view: firstComparedCurrency, raduis: 20.0)
        setupCornerRadius(view: secondComparedCurrency, raduis: 20.0)
        setupAddToFavoriteButton()
        CustomHeader(title: "My Portofolio ", table: tableView)
        setupTableView()
        listenToAutoUpadteTableView()
        compareStackView.isHidden = true
    }
    
    //MARK: -setupCornerRadius Function
    private func setupCornerRadius(view: UIView, raduis: CGFloat, shouldAddBorder: Bool = true) {
        view.layer.cornerRadius = raduis
        if shouldAddBorder {
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    //MARK: -setupAddToFavoriteButton Function
    func setupAddToFavoriteButton() {
        addToFavoriteVytton.layer.borderWidth = 0.91
        addToFavoriteVytton.layer.borderColor = UIColor.black.cgColor
        addToFavoriteVytton.layer.cornerRadius = 18.0
    }
    
    //MARK: -setupTableView Function
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
    }
    
    //MARK: -registerCells Function
    private func registerCells() {
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    //MARK: -listenToAutoUpadteTableView Function
    private func listenToAutoUpadteTableView() {
        viewModel.autoUpdateTableView = { [weak self] in
            guard let self = self else { return }
            if self.viewModel.getCurrencyFlag && self.viewModel.getRatingFlag {
                self.tableView.reloadData()
                self.tableViewHeight.constant = CGFloat((self.favoriteCurrencies.count + 1) * 60)
            }
        }
    }
    
    private func listenToConvertData() {
        viewModel.convertListner = { [weak self] in
            guard let self = self else { return }
            if let data = self.viewModel.dataClass {
                self.amountCurrencyTextField.text = "\(data.amount)"
            }
        }
    }
    private func listenToCompareData() {
        viewModel.compareListner = { [weak self] in
            guard let self = self else { return }
            if let data = self.viewModel.compareClass {
                self.firstComparedCurrency.text = "\(data.amount1)"
                self.secondComparedCurrency.text = "\(data.amount2)"
                
            }
        }
    }
    
    //MARK: -addToFavoriteButtonPressed Buttom
    @IBAction func addToFavoriteButtonPressed(_ sender: Any) {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.modalPresentationStyle = .fullScreen
        favoritesViewController.delegate = self
        self.present(favoritesViewController, animated: true)
    }
    //MARK: -segemntControllerPressed Buttom
    @IBAction func segemntControllerPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            compareStackView.isHidden = true
            convertedStackView.isHidden = false
            convertButton.setTitle("Convert", for: .normal)
            state = .convert
        }else {
            compareStackView.isHidden = false
            convertedStackView.isHidden = true
            convertButton.setTitle("Compare", for: .normal)
            state = .compare
        }
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else {return}
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: -convertButtonPressed Buttom
    @IBAction func convertButtonPressed(_ sender: Any) {
        if ValidationManager.shared.validateTextFieldInput(convertAmountTextField.text ?? "" ) == true {
            switch state {
            case .convert:
                handleConvertButtom()
            case .compare:
                handleCompareButtom()
            }
        } else {
            warningMessage(message: "The input is invalid, please enter numbers")
        }
    }
    
    //MARK: -handleCompareButtom Function
    private func handleCompareButtom() {
        if  selectedIndex != nil,
            let from = fromCurrencyLabel.text,
            let to1 = firstTargetLable.text,
            let to2 = secondTargetLable.text,
            let amount = convertAmountTextField.text {
            self.viewModel.getCompareApiData(from: from, to: to1, amount1: amount, to2: to2)
        }
    }
    
    //MARK: -handleConvertButtom Function
    private func handleConvertButtom() {
        if  selectedIndex != nil, let from = fromCurrencyLabel.text, let to = toCurrencyLable.text, let amount = convertAmountTextField.text {
            self.viewModel.getConvertApiData(from: from, to: to, amount1: amount)
        }
    }
    
    //MARK: -fetchCurrencyDataForDropDown Function
    private func fetchCurrencyDataForDropDown(dropDown: DropDown) {
        NetworkManager.shared.request(url: "https://currencyconversion-production-38ba.up.railway.app/currency/", method: .get) { [weak self] (result: Result<[CurrencyModelElement], Error>) in
            switch result {
            case .success(let currencies):
                self?.favoriteCurrencies = currencies
                self?.arrayOfCurrancies.append(contentsOf: currencies.map({$0.currencyCode}))
                dropDown.dataSource = self?.arrayOfCurrancies ?? []
                print(self?.arrayOfCurrancies ?? "")
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
//MARK: -HomeViewController Extension
extension HomeViewController :UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        cell.configure(model: favoriteCurrencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - HomeViewController Extension
extension HomeViewController: FavoritesViewControllerProtocol {
    func setSelectedCurrencies(currencies: [CurrencyModelElement]) {
        self.favoriteCurrencies = currencies
        
        for (index,currency) in favoriteCurrencies.enumerated() {
            switch currency.currencyCode {
            case "AED":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.aed
            case "JPY":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.jpy
            
            case "EUR":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.eur
            
            case "QAR":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.qar
           
            case "GBP":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.gbp
          
            case "OMR":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.omr
            
            case "SAR":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.sar
           
            case "USD":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.usd
           
            case "KWD":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.kwd
          
            case "BHD":
                favoriteCurrencies[index].rate = viewModel.currenciesRate?.conversionRates.bhd
            default:
                break
            }
        }
        tableView.reloadData()
        self.tableViewHeight.constant = CGFloat((self.favoriteCurrencies.count + 1) * 60)
    }
}
