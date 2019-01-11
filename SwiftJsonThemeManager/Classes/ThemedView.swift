//
//  ThemeManagerProtocol.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 26/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

@objc
public protocol ThemedView {
    func applyUIAppearance(with theme: Theme?, avoid thisViews: [Any]?)
}

// Customize appearance using closure
public typealias ThemedViewCustomTheme = (Theme?) -> Void
public protocol CustomTheme {
	var customTheme: ThemedViewCustomTheme { get }
}
