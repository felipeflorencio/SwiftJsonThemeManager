//
//  ViewController.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

class ViewController: UIViewController {
    
    // MARK: - Initialize Swift JSON Theme Manager 
    let themeManager = ThemeManager.currentTheme
    override func viewDidLoad() {
        super.viewDidLoad()
        applyUIAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
 
    private func setupUI() {
        self.view.applyUIAppearance()
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        let defaultTheme = ThemeManager.currentThemeJson
        
        if defaultTheme == "DefaultTheme" {
            ThemeManager.switchTheme(theme: "CustomTheme")
            return
        }

        ThemeManager.switchTheme(theme: "DefaultTheme")
    }
}

