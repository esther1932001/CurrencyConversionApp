//
//  CurrencyTableViewCell.swift
//  CurrencyConversion
//
//  Created by esterelzek on 22/08/2023.
//

import UIKit

//MARK: -Class of curruncy cell
class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: -Outlets
    @IBOutlet weak var curruncyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageCorner(image: curruncyImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: -Nib Function
    static func nib() -> UINib {
        return UINib(nibName: "CurrencyTableViewCell", bundle: nil)
    }
    //MARK: -Congigure function
    func configure(model: CurrencyModelElement) {
        curruncyImage.kf.setImage(with: URL(string:model.imageURL ))
        currencyName.text = model.currencyCode
        print(model.currencyCode)
        currencyRate.text = model.rate
        print(model.rate)
    }
}
