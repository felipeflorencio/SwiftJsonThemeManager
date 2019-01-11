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
    
    public func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
        
		ThemeManager.registerForThemeUpdates(self)
        
        // Check if I should not try to apply template to this view
        if let list = thisViews {
            let isMyType = list.compactMap({ $0 as? UIViewController })
            if isMyType.first(where: { view in return view.isEqual(self) }) != nil {
                return
            }
        }
        
        let theme = theme ?? ThemeManager.currentTheme
        
        switch viewControllerType {
        case .simpleView:
            self.view.backgroundColor = theme.getThemeColor(name: "backgroundViewController.normalView")
        case .customView:
            self.view.backgroundColor = theme.getThemeColor(name: "backgroundViewController.customView")
        case .notThemed:
            return
        default:
            break
        }
        
        self.view.subviews.forEach {
            $0.applyUIAppearance(with: theme, avoid: thisViews)
        }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
	}
}
