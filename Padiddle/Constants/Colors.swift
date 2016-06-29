// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#007aff"></span>
  /// Alpha: 100% <br/> (0x007affff)
  case AppTint
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#999999"></span>
  /// Alpha: 100% <br/> (0x999999ff)
  case PageIndicator
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#323232"></span>
  /// Alpha: 100% <br/> (0x323232ff)
  case PageIndicatorCurrentPage
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  case Toolbar
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#adadad"></span>
  /// Alpha: 100% <br/> (0xadadadff)
  case ToolbarHairline

  var rgbaValue: UInt32 {
    switch self {
    case .AppTint: return 0x007affff
    case .PageIndicator: return 0x999999ff
    case .PageIndicatorCurrentPage: return 0x323232ff
    case .Toolbar: return 0xffffffff
    case .ToolbarHairline: return 0xadadadff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
