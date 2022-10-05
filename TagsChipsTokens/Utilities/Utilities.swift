//
//  Utilities.swift
//  TagsChipsTokens
//
//  Created by Izaan on 04/10/2022.
//

import Foundation
import UIKit

//MARK: - Extensions
extension UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
}


//MARK: - Protocols
@objc protocol TableViewCellDelegate {
    @objc func click(indexPath: IndexPath?)
    @objc func click(indexPath: IndexPath?, value: Any?)
}

//MARK: - AppHelper
class AppHelper: NSObject {
    
    static func isValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
}

//MARK: - Constants
class Constants {
    struct Colors {
        static let themeColor = UIColor(named: "ThemeColor")!
        static let secondaryColor = UIColor(named: "SecondaryColor")!
        static let secondaryThemeColor = UIColor(named: "SecondaryThemeColor")!
    }
}

//MARK: - CustomizeView
@IBDesignable class CustomizeView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet{
            self.layer.shadowColor = self.shadowColor.cgColor
            self.layer.shadowOpacity = 0.8
            self.layer.shadowOffset = .zero
            self.layer.shadowRadius = 2
        }
    }
}
