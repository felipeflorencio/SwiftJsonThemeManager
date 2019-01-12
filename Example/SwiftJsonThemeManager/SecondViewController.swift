//
//  SecondViewController.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

class SecondViewController: UIViewController {

    @IBOutlet weak var notThemedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyUIAppearance()
    }
}

extension SecondViewController: CustomTheme {
    var customTheme: ThemedViewCustomTheme {
        return { [weak self] theme -> Void in
            
            guard let currentTheme = theme, let `self` = self else { return }
            
            self.notThemedView.backgroundColor = currentTheme.getThemeColor(name: "textColor")
        }
    }
}
