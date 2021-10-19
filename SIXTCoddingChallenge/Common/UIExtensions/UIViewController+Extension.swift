//
//  UIViewController+Extension.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/20/21.
//

import UIKit

extension UIViewController {
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        show(alert, sender: nil)
    }
}
