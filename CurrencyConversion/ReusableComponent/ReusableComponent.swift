//
//  ReusableComponent.swift
//  CurrencyConversion
//
//  Created by esterelzek on 28/08/2023.
//

import Foundation
import UIKit

//MARK: -setImageCorner Function
public func setImageCorner(image: UIImageView) {
    image.layer.cornerRadius = 35
    image.layer.masksToBounds = true
}
//MARK: -CustomHeader Function
public func CustomHeader(title: String, table: UITableView) {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.width, height: 50))
    headerView.backgroundColor = UIColor.white
    let titleLabel = UILabel(frame: headerView.frame)
    titleLabel.text = title
    titleLabel.textAlignment = .left
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.textColor = UIColor.black
    headerView.addSubview(titleLabel)
    table.tableHeaderView = headerView
}
