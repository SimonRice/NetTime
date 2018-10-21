//
//  FontAwesomeTabBarItem.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import FontAwesome
import os
import UIKit

class FontAwesomeTabBarItem: UITabBarItem {
    @IBInspectable var iconName: String = "" {
        didSet {
            let prefix: String = self.iconName.hasPrefix("fa-") ? "" : "fa-"

            if let fontAwesomeValue = String.fontAwesomeIcon(code: "\(prefix)\(self.iconName)"),
                let fontAwesomeGlyph = FontAwesome(rawValue: fontAwesomeValue) {
                let size = CGSize(width: 30, height: 30)
                self.image = UIImage.fontAwesomeIcon(name: fontAwesomeGlyph,
                                                     style: .solid,
                                                     textColor: .black,
                                                     size: size)
            } else {
                os_log("%@", type: .error,
                       "Cound not find icon for \(self.iconName)")
            }
        }
    }
}
