//
//  Extentions.swift
//  CurrencyConversion
//
//  Created by esterelzek on 28/08/2023.
//

import Foundation
import UIKit
extension HomeViewController {
    func warningMessage (message: String){
        let dialogMessage = UIAlertController(title: "Warning", message: message , preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
