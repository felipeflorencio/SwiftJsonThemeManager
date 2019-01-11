//
//  ThemeManager.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 26/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//

import UIKit

public class ThemeManager {

    public internal(set) static var current: Theme = SwiftJsonThemeManager.initWithJson()

    private static var viewsTable = NSHashTable<UIViewController>(options: .weakMemory)

    public static func registerForThemeUpdates(_ view: ThemedView) {
        viewsTable.add(view as? UIViewController)
    }

    public static func updateAllViews(with theme: Theme?) {
        viewsTable.allObjects.forEach { (view) in
            if view is ThemedView {
                (view as! ThemedView).applyUIAppearance(with: theme, avoid: nil)
            }
        }
    }

    public static var currentTheme: Theme {
        return current
    }
}
