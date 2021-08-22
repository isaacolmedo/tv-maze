//
//  TVMaze+Colors.swift
//  TVMaze
//
//  Created by Isaac Olmedo on 22/08/21.
//

import UIKit

extension UIColor {
    static var primary: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "primary")!
        } else {
            return UIColor(displayP3Red: 84/255, green: 146/255, blue: 139/255, alpha: 1)
        }
    }
    
    static var foregroundBar: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "foregroundBar")!
        } else {
            return UIColor(displayP3Red: 63/255, green: 63/255, blue: 63/255, alpha: 1)
        }
    }
}

