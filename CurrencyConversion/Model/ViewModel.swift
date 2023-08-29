//
//  ViewModel.swift
//  CurrencyConversion
//
//  Created by esterelzek on 22/08/2023.
//

//MARK: -ViewModel class
import Foundation

enum CurrencyState {
    case convert
    case compare
}

class ViewModel {
    
    //MARK: -Varibles
    var autoUpdateTableView: (()->())?
    var currenciesRate: CurrencyModel?
    var  convertData: ConvertData?////////////
    var dataClass: ConvertClass?//////
    var compareData: CompareData?
    var compareClass: DataCompare?
    private var currencies: [CurrencyModelElement] = []
    private (set) var getCurrencyFlag = false
    private (set) var getRatingFlag = false
    var onDataUpdate: (() -> Void)?
    var convertListner: (() -> Void)?
    var compareListner: (() -> Void)?
    
    //MARK: -fetchCurrencyData Function
    public func fetchCurrencyData() {
        NetworkManager.shared.request(url: "https://currencyconversion-production-38ba.up.railway.app/currency/compare?base=EGP", method: .get) { [weak self] (result: Result<CurrencyModel, Error>) in
            switch result {
            case .success(let currenciesRate):
                self?.currenciesRate = currenciesRate
            case .failure(let failure):
                print(failure)
            }
        }
    }
    //MARK: -getConvertApiData Function
    func getConvertApiData(from: String, to: String, amount1: String) {
        NetworkManager.shared.request(url: "https://graduationprojectbm.up.railway.app/api/v1/currency/conversion?from=\(from)&to1=\(to)&amount=\(amount1)", method: .get) { [weak self] (result: Result<ConvertData, Error>) in
            switch result {
            case .success(let convertData):
                self?.convertData = convertData
                self?.dataClass = convertData.data
                print("currencies:",convertData)
                self?.convertListner?()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //MARK: -getCompareApiData Function
    func getCompareApiData(from: String, to: String, amount1: String, to2 : String) {
        NetworkManager.shared.request(url: "https://graduationprojectbm.up.railway.app/api/v1/currency/conversion?from=\(from)&to1=\(to)&amount=\(amount1)&to2=\(to2)", method: .get) { [weak self] (result: Result<CompareData, Error>) in
            switch result {
            case .success(let compareData):
                self?.compareData = compareData
                self?.compareClass = compareData.data
                print("currencies:",compareData)
                self?.compareListner?()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
