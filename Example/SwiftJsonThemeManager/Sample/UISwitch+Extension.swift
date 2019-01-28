// Made with Swift Json Theme Manager Template by Felipe Garcia
//
//  UISwitchExtension.swift
//  SwiftJsonThemeManager_Example
//
//  Created by Felipe Florencio Garcia on 25/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftJsonThemeManager

public enum SwitchTheme: String {
    case normal
    case custom
    case none
}

extension UISwitch {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
    @IBInspectable var identifierUISwitchExtensionName: String {
        get {
            return associatedObject(base: self, key: &switchId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &switchId, value: newValue as NSString)
        }
    }

    public var viewSwitchTheme: SwitchTheme {
        get {
            return SwitchTheme(rawValue: identifierUISwitchExtensionName) ?? .none
        }
        set {
            identifierUISwitchExtensionName = newValue.rawValue
        }
    }
}

extension UISwitch {
  
    public override func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
  
        let theme = theme ?? ThemeManager.currentTheme

        switch viewSwitchTheme {
          case .normal:
            onTintColor = theme.getThemeColor(name: "switch.colorOn")
            tintColor = theme.getThemeColor(name: "switch.colorOff")
          case .custom:
            onTintColor = theme.getThemeColor(name: "switch.colorOn")
            tintColor = theme.getThemeColor(name: "switch.colorOff")
          case .none: return
        }

        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
