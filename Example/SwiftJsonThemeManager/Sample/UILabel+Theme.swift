// Made with Json Theme Swift Template by Felipe Garcia 
//
//  UILabel+Theme.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

public var customUILabelThemeId: UInt8 = 2

public enum LabelTheme: String {
    // Add your types here
    case sourceSansProSemiboldIt
    case sourceSansProIt
    case sourceSansSemibold
    case plamati
    case none
}

extension UILabel {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
    @IBInspectable var identifierUILabelThemeName: String {
        get {
            return associatedObject(base: self, key: &customUILabelThemeId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &customUILabelThemeId, value: newValue as NSString)
        }
    }

    public var viewLabelTheme: LabelTheme {
        get {
            return LabelTheme(rawValue: identifierUILabelThemeName) ?? .none
        }
        set {
            identifierUILabelThemeName = newValue.rawValue
        }
    }
}

extension UILabel {
  
    public override func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
  
        // Check if I should not try to apply template to this view
        // Or to avoid when UIView try to apply theme to subview
        if let list = thisViews {
            let isMyType = list.compactMap({ $0 as? UILabel })
            if isMyType.first(where: { view in return view.isEqual(self) }) != nil {
                return
            }
        }
        
        let theme = theme ?? ThemeManager.currentTheme

        switch viewLabelTheme {
            case .sourceSansProSemiboldIt:
                font = theme.getThemedFont(name: "titleFont")
                textColor = theme.getThemeColor(name: "titleTextColor")
            case .sourceSansProIt:
                font = theme.getThemedFont(name: "textStyleNormalLarge")
                textColor = theme.getThemeColor(name: "textStyleNormalLargeColor")
            case .sourceSansSemibold: break
            case .plamati: break
	        default: break
        }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
