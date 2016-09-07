// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum Asset: String {
  case helpButton = "HelpButton"
  case iPad = "iPad"
  case iPhone = "iPhone"
  case pauseButton = "PauseButton"
  case recordButtonBack = "RecordButtonBack"
  case recordButtonBlank = "RecordButtonBlank"
  case recordButtonFront = "RecordButtonFront"
  case shareButton = "ShareButton"
  case trashButton = "TrashButton"

  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
