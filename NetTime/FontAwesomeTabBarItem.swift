//
//  FontAwesomeTabBarItem.swift
//  NetTime
//
//  Created by Simon Rice on 13/03/2016.
//  Copyright © 2016 Simon Rice. All rights reserved.
//

import FontAwesome
import UIKit

class FontAwesomeTabBarItem: UITabBarItem {
    @IBInspectable var iconName: String = "" {
        didSet {
            let prefix: String = self.iconName.hasPrefix("fa-") ? "" : "fa-"

            if let fontAwesomeValue = String.fontAwesomeIconWithCode("\(prefix)\(self.iconName)"),
                fontAwesomeGlyph = FontAwesome(rawValue: fontAwesomeValue) {
                    self.image = UIImage.fontAwesomeIconWithName(fontAwesomeGlyph,
                        textColor: UIColor.blackColor(),
                        size: CGSize(width: 30, height: 30)
                    )
            } else {
//                Log.warning("Cound not find icon for \(self.iconName)")
            }
        }
    }
}
