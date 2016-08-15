//
//  DrawingView.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 10/7/15.
//  Copyright © 2015 Zev Eisenberg. All rights reserved.
//

import UIKit

class DrawingView: UIView, DrawingViewBoundsVendor {
    fileprivate var needsErase = true
    fileprivate let screenScale = UIScreen.main.scale

    fileprivate var displayLink: CADisplayLink?

    fileprivate var viewModel: DrawingViewModel

    var isUpdating: Bool {
        get {
            return viewModel.isUpdating
        }
        set {
            viewModel.isUpdating = newValue
        }
    }

    var needToMoveNibToNewStartLocation: Bool {
        get {
            return viewModel.needToMoveNibToNewStartLocation
        }
        set {
            viewModel.needToMoveNibToNewStartLocation = newValue
        }
    }

    init(viewModel: DrawingViewModel) {

        self.viewModel = viewModel

        super.init(frame: CGRect.zero)

        viewModel.view = self

        displayLink = CADisplayLink(target: self, selector: #selector(DrawingView.displayLinkUpdated))
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    func startDrawing() {
        displayLink?.isPaused = false
    }

    func stopDrawing() {
        displayLink?.isPaused = true
    }

    func clear() {
        viewModel.clear()
        setNeedsDisplay()
    }

    func addPoint(_ point: CGPoint) {
        viewModel.addPoint(point)
    }

    func restartAtPoint(_ point: CGPoint) {
        viewModel.restartAtPoint(point)
    }

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            viewModel.drawInto(context, dirtyRect: rect)
        }
    }

    func setInitialImage(_ image: UIImage) {
        viewModel.setInitialImage(image)
    }
}

private extension DrawingView {
    @objc func displayLinkUpdated() { // marked @objc so it can be looked up by selector
        setNeedsDisplay(viewModel.convertContextRectToViewCoordinates(viewModel.currentDirtyRect))
    }
}
