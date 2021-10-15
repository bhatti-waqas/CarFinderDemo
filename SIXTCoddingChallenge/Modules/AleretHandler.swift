//
//  AleretHandler.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import UIKit

class AlertHandler {
    
    public static func showError(_ controller:UIViewController, error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public static func showAlert(_ controller:UIViewController,title:String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
