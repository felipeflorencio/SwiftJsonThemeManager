//
//  Theme+SwiftJsonThemeManager.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 26/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//


import UIKit

@objc public protocol Theme {
	func getThemedFont(name: String) -> UIFont

	func getThemeColor(name: String) -> UIColor

	func getThemeImage(name: String) -> UIImage
}

extension SwiftJsonThemeManager: Theme {

    static func initWithJson(with jsonName: String = ThemeManager.currentThemeJson) -> SwiftJsonThemeManager {
		return SwiftJsonThemeManager(jsonFile: jsonName)
	}

	public func getThemedFont(name: String) -> UIFont {
		return themedFont(name)
	}

	public func getThemeColor(name: String) -> UIColor {
		return themedColor(name)
	}

	public func getThemeImage(name: String) -> UIImage {
		return themedImage(name)
	}
}
