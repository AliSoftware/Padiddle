//
//  ToolbarViewModel.swift
//  Padiddle
//
//  Created by Zev Eisenberg on 9/18/15.
//  Copyright © 2015 Zev Eisenberg. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ToolbarViewModelToolbarDelegate:
class {
    func setToolbarVisible(visible: Bool, animated: Bool)
}

protocol ToolbarViewModelColorDelegate:
class {
    func colorManagerPicked(colorManager: ColorManager)
}

class ToolbarViewModel {
    var colorPickerViewModel: ColorPickerViewModel?

    let rootViewModel: RootViewModel

    weak var toolbarDelegate: ToolbarViewModelToolbarDelegate?
    weak var colorDelegate: ToolbarViewModelColorDelegate?

    required init(rootViewModel: RootViewModel, toolbarDelegate: ToolbarViewModelToolbarDelegate, colorDelegate: ToolbarViewModelColorDelegate) {
        self.rootViewModel = rootViewModel
        self.toolbarDelegate = toolbarDelegate
        self.colorDelegate = colorDelegate
        colorPickerViewModel = ColorPickerViewModel(delegate: self)
    }

    func recordButtonTapped() {
        rootViewModel.recording = !rootViewModel.recording
    }

    func clearTapped() {
        rootViewModel.clearTapped()
    }

    func getSnapshotImage(interfaceOrientation: UIInterfaceOrientation, completion: UIImage -> Void) {
        rootViewModel.getSnapshotImage(interfaceOrientation, completion: completion)
    }
}

extension ToolbarViewModel: RecordingDelegate {
    @objc func recordingStatusChanged(recording: Bool) {
        toolbarDelegate?.setToolbarVisible(!recording, animated: true)
    }
}

extension ToolbarViewModel: ColorPickerViewModelDelegate {
    func colorManagerPicked(colorManager: ColorManager) {
        colorDelegate?.colorManagerPicked(colorManager)
    }
}
