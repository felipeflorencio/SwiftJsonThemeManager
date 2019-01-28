// Made with Swift Json Theme Manager Template by Felipe Garcia
//
//  UIButtonExtension.swift
//  SwiftJsonThemeManager_Example
//
//  Created by Felipe Florencio Garcia on 25/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftJsonThemeManager

public enum ButtonTheme: String {
    case common
    case roundedButton
    case typeNormal
    case typeColored
    case typeCustom
    case none
}

extension UIButton {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
    @IBInspectable var identifierUIButtonExtensionName: String {
        get {
            return associatedObject(base: self, key: &buttonId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &buttonId, value: newValue as NSString)
        }
    }

    public var viewButtonTheme: ButtonTheme {
        get {
            return ButtonTheme(rawValue: identifierUIButtonExtensionName) ?? .none
        }
        set {
            identifierUIButtonExtensionName = newValue.rawValue
        }
    }
}

extension UIButton {
  
    public override func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
  
        let theme = theme ?? ThemeManager.currentTheme

        switch viewButtonTheme {
            case .common:
                backgroundColor = theme.getThemeColor(name: "normalColor")
                titleLabel?.font = theme.getThemedFont(name: "button.commonButtonFont")
                setTitleColor(theme.getThemeColor(name: "button.commonButtonColor"), for: .normal)
            case .roundedButton:
                backgroundColor = theme.getThemeColor(name: "centerColor")
                titleLabel?.font = theme.getThemedFont(name: "button.centerButtonFont")
                setTitleColor(theme.getThemeColor(name: "button.centerButtonColor"), for: .normal)
            case .typeNormal:
                backgroundColor = theme.getThemeColor(name: "buttonBlueColor")
                titleLabel?.font = theme.getThemedFont(name: "button.themeSelectButtonFont")
                setTitleColor(theme.getThemeColor(name: "button.themeSelectButtonColor"), for: .normal)
            case .typeColored:
                backgroundColor = theme.getThemeColor(name: "buttonRedColor")
                titleLabel?.font = theme.getThemedFont(name: "button.themeSelectButtonFont")
                setTitleColor(theme.getThemeColor(name: "button.themeSelectButtonColor"), for: .normal)
            case .typeCustom:
                backgroundColor = theme.getThemeColor(name: "buttonYellowColor")
                titleLabel?.font = theme.getThemedFont(name: "button.themeSelectButtonFont")
                setTitleColor(theme.getThemeColor(name: "button.themeSelectButtonColor"), for: .normal)
	        case .none: return
        }

        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
