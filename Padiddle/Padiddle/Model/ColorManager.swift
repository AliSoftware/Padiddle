//
//  ColorManager.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 9/15/15.
//  Copyright © 2015 Zev Eisenberg. All rights reserved.
//

import UIKit.UIColor

private let π = CGFloat(M_PI)
private let twoPi = 2.0 * π

enum ColorMode {
    case ThetaIncreasing
    case ThetaIncreasingAndDecreasing
    case VelocityOut
    case VelocityIn
    case Manual(CGFloat)
}

enum ColorModel {
    case HSV(h: ColorMode, s: ColorMode, v: ColorMode)
    case RGB(r: ColorMode, g: ColorMode, b: ColorMode)
}

struct ColorManager {
    var radius: CGFloat = 0
    private var _theta: CGFloat = 0
    var theta: CGFloat {
        set {
            _theta = newValue - twoPi * floor(newValue / twoPi)
        }
        get {
            return _theta
        }
    }

    var maxRadius: CGFloat = 0

    let colorModel: ColorModel

    var title: String

    var currentColor: UIColor {
        return self.dynamicType.color(colorModel: colorModel, radius: radius, maxRadius: maxRadius, theta: theta)
    }

    init(colorModel: ColorModel, title: String) {
        self.colorModel = colorModel
        self.title = title
    }

    private static func color(colorModel colorModel: ColorModel, radius: CGFloat, maxRadius: CGFloat, theta: CGFloat) -> UIColor {
        let color: UIColor
        switch colorModel {
        case let .HSV(hMode, sMode, vMode):
            let h = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: hMode)
            let s = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: sMode)
            let v = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: vMode)
            color = UIColor(hue: h, saturation: s, brightness: v, alpha: 1)
        case let .RGB(rMode, gMode, bMode):
            let r = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: rMode)
            let g = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: gMode)
            let b = channelValue(radius, maxRadius: maxRadius, theta: theta, colorMode: bMode)
            color = UIColor(red: r, green: g, blue: b, alpha: 1)
        }

        return color
    }

    private static func channelValue(radius: CGFloat, maxRadius: CGFloat, theta: CGFloat, colorMode: ColorMode) -> CGFloat {
        let channelValue: CGFloat
        switch colorMode {
        case .ThetaIncreasing:
            channelValue = theta / twoPi

        case .ThetaIncreasingAndDecreasing:
            var value: CGFloat
            if theta > π {
                value = twoPi - theta
            }
            else {
                value = theta
            }
            channelValue = value / π

        case .VelocityOut:
            assert(maxRadius > 0)
            channelValue = radius / maxRadius

        case .VelocityIn:
            assert(maxRadius > 0)
            channelValue = 1 - (radius / maxRadius)

        case let .Manual(value):
            channelValue = value
        }

        return channelValue
    }
}
