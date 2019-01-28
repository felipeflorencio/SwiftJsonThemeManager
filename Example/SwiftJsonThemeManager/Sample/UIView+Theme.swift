//
//  UIView+Theme.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

public enum ViewThemeType: String {
    case none
    case simpleView
    case simpleViewColored
    case notThemed
}

extension UIView {
    @IBInspectable var viewName: String {
        get {
            return associatedObject(base: self, key: &viewId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &viewId, value: newValue as NSString)
        }
    }

    public var viewType: ViewThemeType {
        get {
            return ViewThemeType(rawValue: viewName) ?? .none
        }
        set {
            viewName = newValue.rawValue
        }
    }
}

extension UIView: ThemedView {
  
    open override func awakeFromNib() {
        super.awakeFromNib()
        applyUIAppearance()
    }
    
    public func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
        
        guard !(self is UICollectionView) else { return }
        
        let theme = theme ?? ThemeManager.currentTheme

        switch viewType {
        case .simpleView:
            backgroundColor = theme.getThemeColor(name: "view.simpleViewColor")
        case .simpleViewColored:
            backgroundColor = theme.getThemeColor(name: "view.simplesViewColoredColor")
        case .notThemed: return
        default: break
        }

        self.subviews.forEach {
            $0.applyUIAppearance(with: theme, avoid: thisViews)
        }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
