//
//  UIViewController+Theme.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

public enum ViewControllerThemeType: String {
    case none
    case simpleView
    case customView
    case notThemed
}

extension UIViewController {
    
    @IBInspectable public var controllerName: String {
        get {
            return associatedObject(base: self, key: &viewControllerId, initialiser: { () -> NSString in
                return "none"
            }) as String
        }
        set {
            associateObject(base: self, key: &viewControllerId, value: newValue as NSString)
        }
    }

    public var viewControllerType: ViewControllerThemeType {
        get {
            return ViewControllerThemeType(rawValue: controllerName) ?? .none
        }
        set {
            controllerName = newValue.rawValue
        }
    }
}

extension UIViewController: ThemedView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        applyUIAppearance()
    }
    
    public func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
        
		ThemeManager.registerForThemeUpdates(self)
        
        let theme = theme ?? ThemeManager.currentTheme
        
        switch viewControllerType {
        case .simpleView:
            self.view.backgroundColor = theme.getThemeColor(name: "backgroundViewController.defaultView")
        case .customView:
            self.view.backgroundColor = theme.getThemeColor(name: "backgroundViewController.themeListViewController")
        case .notThemed: return
        default: break
        }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
	}
}
