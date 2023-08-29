//
//  FavoritesTableViewCell.swift
//  CurrencyConversion
//
//  Created by esterelzek on 24/08/2023.
//

import UIKit
//MARK: -Class FavoritesTableViewCell
class FavoritesTableViewCell: UITableViewCell {
    //MARK: -Outlets
    @IBOutlet weak var flageImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    //MARK: -Variables Of Protocol
    var delegete: FavoritesTableViewCellProtocol?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageCorner(image: flageImage)
    }
    
    //MARK: -closeButtom
    @IBAction func selectedButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegete?.setSelection(isSelected: sender.isSelected, index: index)
    }
    //MARK: -Configure the view for the selected state
    func configure(model: CurrencyModelElement) {
        
        flageImage.kf.setImage(with: URL(string:model.imageURL ))
        currencyName.text = model.currencyCode
    }
}
//MARK: -FavoritesTableViewCellProtocol
protocol FavoritesTableViewCellProtocol: AnyObject {
    func setSelection(isSelected: Bool , index: Int)
}

