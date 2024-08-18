//
//  Extensions.swift
//  iOSGeekMVP
//
//  Created by Sanjay Vekariya on 8/12/24.
//

import UIKit

extension String {
    var abbreviation: String {
        let nameComponents = split(separator: " ")
        let initials = nameComponents.compactMap { $0.first }.prefix(2)
        return initials.map { String($0) }.joined()
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var randomColor: UIColor {
        return UIColor(
           red: .random,
           green: .random,
           blue: .random,
           alpha: 1.0
        )
    }
}
