// Made with Json Theme Swift Template by Felipe Garcia 
//
//  UILabel+Theme.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

public enum LabelTheme: String {
    // Add your types here
    case sourceSansProSemiboldIt
    case sourceSansProIt
    case sourceSansSemibold
    case plamatic
    case none
}

extension UILabel {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
    @IBInspectable var identifierUILabelThemeName: String {
        get {
            return associatedObject(base: self, key: &labelId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &labelId, value: newValue as NSString)
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
        
        let theme = theme ?? ThemeManager.currentTheme

        switch viewLabelTheme {
            case .sourceSansProSemiboldIt: break
            case .sourceSansProIt:
                font = theme.getThemedFont(name: "label.commonLabelFont")
                textColor = theme.getThemeColor(name: "label.commonLabelColor")
            case .sourceSansSemibold: break
            case .plamatic:
                font = theme.getThemedFont(name: "label.customLabelFont")
                textColor = theme.getThemeColor(name: "label.customLabelColor")
	        default: break
        }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
