//
//  ScreenExtensions.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 10/7/15.
//  Copyright © 2015 Zev Eisenberg. All rights reserved.
//

import UIKit

extension UIScreen {
    var longestSide: CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return max(width, height)
    }
}
