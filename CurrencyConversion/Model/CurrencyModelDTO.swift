//
//  Model.swift
//  CurrencyConversion
//
//  Created by esterelzek on 22/08/2023.
//

import Foundation

// MARK: - CurrencyModel
struct CurrencyModel: Codable {
    let baseCode: String
    let conversionRates: ConversionRates

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

// MARK: - ConversionRates
struct ConversionRates: Codable {
    let aed, jpy, eur, qar: String
    let gbp, omr, sar, usd: String
    let kwd, bhd: String

    enum CodingKeys: String, CodingKey {
        case aed = "AED"
        case jpy = "JPY"
        case eur = "EUR"
        case qar = "QAR"
        case gbp = "GBP"
        case omr = "OMR"
        case sar = "SAR"
        case usd = "USD"
        case kwd = "KWD"
        case bhd = "BHD"
    }
}

// MARK: - CurrencyModelElement
struct CurrencyModelElement: Codable {
    let currencyCode: String
    let imageURL: String
    var isSelected: Bool?
    var rate: String?

    enum CodingKeys: String, CodingKey {
        case currencyCode = "currency_code"
        case imageURL = "image_url"
        case isSelected, rate
    }
}

typealias CurrencyModelImagese = [CurrencyModelElement]

// MARK: - ConvertData
struct ConvertData: Codable {
    let statusCode: Int
    let isSuccess: Bool
    let data: ConvertClass
}

// MARK: - DataClass
struct ConvertClass: Codable {
    let source, destination: String
    let amount: Double
}

// MARK: - CompareData
struct CompareData: Codable {
    let statusCode: Int
    let isSuccess: Bool
    let data: DataCompare
}

// MARK: - DataClass
struct DataCompare: Codable {
    let source, destination1, destination2: String
    let amount1, amount2: Double
}

