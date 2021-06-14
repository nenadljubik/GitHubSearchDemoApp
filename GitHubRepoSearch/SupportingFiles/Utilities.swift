//
//  Utilities.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import Foundation
import UIKit

class Utilities {

    static let sharedInstance = Utilities()

    // MARK:- Converting JSON to Data
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }

    // MARK:- Create Label
    func createLabel(text: String, txtAlignment: NSTextAlignment, font: UIFont, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = txtAlignment

        return label
    }

    // MARK:- Create TextField
    func createTextField(placeHolder: String, txtAlignment: NSTextAlignment, font: UIFont, textColor: UIColor, backgroundColor: UIColor, corner: CGFloat, returnKeyType: UIReturnKeyType) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textColor = textColor
        textField.backgroundColor = backgroundColor
        textField.font = font
        textField.textAlignment = txtAlignment

        textField.autocorrectionType = .no
        textField.returnKeyType = returnKeyType
        textField.layer.cornerRadius = corner

        return textField
    }

    // MARK:- Presenting Alert With Title
    func presentAlertWith(on viewController: UIViewController?, with title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        viewController?.present(alert, animated: true, completion: nil)
    }

    //MARK: - Checking For Internet Connection
    func hasInternetConnection() -> Bool {
        return Reachability.sharedInstance.isInternetAvailable()
    }
}
