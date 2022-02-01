//
//  UIColor_Extension.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import UIKit

public extension UIColor {
    
    /**
    - parameter hexString: A case insensitive String? representing a hex or CSS value e.g.
    
    - **"abc"**
    - **"abc7"**
    - **"#abc7"**
    - **"00FFFF"**
    - **"#00FFFF"**
    - **"00FFFF77"**
    - **"Orange", "Azure", "Tomato"** Modern browsers support 140 color names (<http://www.w3schools.com/cssref/css_colornames.asp>)
    - **"Clear"** [UIColor clearColor]
    - **"Transparent"** [UIColor clearColor]
    - **nil** [UIColor clearColor]
    - **empty string** [UIColor clearColor]
    */
    convenience init(hex: String?) {
        let normalizedHexString: String = UIColor.normalize(hex)
        var c: CUnsignedLongLong = 0
        Scanner(string: normalizedHexString).scanHexInt64(&c)
        self.init(red:UIColorMasks.redValue(c), green:UIColorMasks.greenValue(c), blue:UIColorMasks.blueValue(c), alpha:UIColorMasks.alphaValue(c))
    }
        
    fileprivate enum UIColorMasks: CUnsignedLongLong {
          
          case alphaMask   = 0xff000000
          case redMask     = 0x00ff0000
          case greenMask   = 0x0000ff00
          case blueMask    = 0x000000ff
          
          static func alphaValue(_ value: CUnsignedLongLong) -> CGFloat {
              return CGFloat((value & alphaMask.rawValue) >> 24) / 255.0
          }
          
          static func redValue(_ value: CUnsignedLongLong) -> CGFloat {
              return CGFloat((value & redMask.rawValue) >> 16) / 255.0
          }
          
          static func greenValue(_ value: CUnsignedLongLong) -> CGFloat {
              return CGFloat((value & greenMask.rawValue) >> 8) / 255.0
          }
          
          static func blueValue(_ value: CUnsignedLongLong) -> CGFloat {
              return CGFloat(value & blueMask.rawValue) / 255.0
          }
      }
    
    fileprivate static func normalize(_ hex: String?) -> String {
        guard var hexString = hex else {
            return "00000000"
        }
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        if hexString.count == 3 || hexString.count == 4 {
            hexString = hexString.map { "\($0)\($0)" } .joined()
        }
        
        if hexString.count < 8 {
            hexString = "ff" + hexString
        }
        return hexString
    }
}
