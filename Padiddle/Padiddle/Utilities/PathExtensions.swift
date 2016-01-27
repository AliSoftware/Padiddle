//
//  PathExtensions.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 1/26/16.
//  Copyright © 2016 Zev Eisenberg. All rights reserved.
//

import CoreGraphics.CGPath

extension CGPathRef {
    class func smoothedPath(points: [CGPoint]) -> CGPathRef {
        assert(points.count == 4)

        let p0 = points[0]
        let p1 = points[1]
        let p2 = points[2]
        let p3 = points[3]

        let c1 = CGPoint(
            x: (p0.x + p1.x) / 2.0,
            y: (p0.y + p1.y) / 2.0)
        let c2 = CGPoint(
            x: (p1.x + p2.x) / 2.0,
            y: (p1.y + p2.y) / 2.0)
        let c3 = CGPoint(
            x: (p2.x + p3.x) / 2.0,
            y: (p2.y + p3.y) / 2.0)

        let len1 = sqrt(pow(p1.x - p0.x, 2.0) + pow(p1.y - p0.y, 2.0))
        let len2 = sqrt(pow(p2.x - p1.x, 2.0) + pow(p2.y - p1.y, 2.0))
        let len3 = sqrt(pow(p3.x - p2.x, 2.0) + pow(p3.y - p2.y, 2.0))

        let divisor1 = len1 + len2
        let divisor2 = len2 + len3

        let k1 = len1 / divisor1
        let k2 = len2 / divisor2

        let m1 = CGPoint(
            x: c1.x + (c2.x - c1.x) * k1,
            y: c1.y + (c2.y - c1.y) * k1)
        let m2 = CGPoint(
            x: c2.x + (c3.x - c2.x) * k2,
            y: c2.y + (c3.y - c2.y) * k2)

        let smoothValue = CGFloat(0.5)
        let ctrl1 = CGPoint(
            x: m1.x + (c2.x - m1.x) * smoothValue + p1.x - m1.x,
            y: m1.y + (c2.y - m1.y) * smoothValue + p1.y - m1.y
        )
        let ctrl2 = CGPoint(
            x: m2.x + (c2.x - m2.x) * smoothValue + p2.x - m2.x,
            y: m2.y + (c2.y - m2.y) * smoothValue + p2.y - m2.y
        )

        let pathSegment = CGPathCreateMutable()
        CGPathMoveToPoint(pathSegment, nil, points[1].x, points[1].y)
        CGPathAddCurveToPoint(pathSegment, nil, ctrl1.x, ctrl1.y, ctrl2.x, ctrl2.y, points[2].x, points[2].y)

        return pathSegment
    }
}
