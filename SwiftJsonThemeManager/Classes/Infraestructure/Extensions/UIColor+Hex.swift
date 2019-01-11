//
//  UIColor+Hex.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 26/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//
import Foundation
import UIKit

extension UIColor {

	class func colorFromHexString(color hexString: String) -> UIColor {
		let rgbValue: UInt32 = self.unsignedIntFromHexString(hexString)
		return UIColor(red: CGFloat(CFloat(((rgbValue&0xFF0000)>>16))/255.0), green: CGFloat(CFloat(((rgbValue&0x00FF00)>>8))/255.0), blue: CGFloat(CFloat(((rgbValue&0x0000FF)>>0))/255.0), alpha: 1.0)
	}
	
	class func unsignedIntFromHexString(_ hexStr: String) -> UInt32 {
		var hexInt: UInt32 = 0
		let scanner: Scanner = Scanner(string: hexStr)
		scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
		return hexInt
	}
	
}

