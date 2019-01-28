//
//  ThemeListViewController.swift
//  SwiftJsonThemeManager_Example
//
//  Created by Felipe Florencio Garcia on 24/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftJsonThemeManager

class ThemeListViewController: UIViewController {

    @IBOutlet weak var redView: UIButton!
    @IBOutlet weak var yellowView: UIButton!
    @IBOutlet weak var blueView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyUIAppearance()
    }
    
    @IBAction func selectTheme(_ sender: UIButton) {
    
        switch sender.viewButtonTheme {
        case .typeNormal:
            ThemeManager.switchTheme(theme: "BlueTheme")
        case .typeColored:
            ThemeManager.switchTheme(theme: "RedTheme")
        case .typeCustom:
            ThemeManager.switchTheme(theme: "YellowTheme")
        default: break
        }
    }
}

// Example how to 'override' the implementation and add a custom to this
// UIViewController or any item that you want to direct access and adjust
extension ThemeListViewController: CustomTheme {
    var customTheme: ThemedViewCustomTheme {
        return { [weak self] theme -> Void in
            
//            guard let currentTheme = theme, let `self` = self else { return }
            
//            self?.blueView.backgroundColor = UIColor.brown
        }
    }
}
