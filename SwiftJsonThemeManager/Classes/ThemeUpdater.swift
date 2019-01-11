//
//  ThemeUpdater.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 30/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

@objc public protocol ThemeUpdater {
    func switchTheme(theme: String)
}

extension ThemeManager: ThemeUpdater {
  
    public static func switchTheme(theme: String) {
        // store the new theme in user defaults
        currentThemeJson = theme
        ThemeManager.current = SwiftJsonThemeManager.initWithJson(with: theme)
        ThemeManager.updateAllViews(with: ThemeManager.current)
    }
    
    public func switchTheme(theme: String) {
        switchTheme(theme: theme)
    }
    
    public static var currentThemeJson: String {
        get {
            guard let storedTheme = defaults.string(forKey: UserDefaults.CommonKeys.currentTheme) else {
                return UserDefaults.CommonKeys.currentTheme
            }
            return storedTheme
        }
        set {
            defaults.set(newValue, forKey: UserDefaults.CommonKeys.currentTheme)
            defaults.synchronize()
        }
    }
}

fileprivate extension ThemeManager {
    static let defaults = UserDefaults.standard
}
