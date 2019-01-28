//
//  ViewController.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Garcia on 01/11/2019.
//  Copyright (c) 2019 Felipe Garcia. All rights reserved.
//

import SwiftJsonThemeManager

class MainViewController : UIViewController {
    
    @IBOutlet weak var dayNightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSwitchState()
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        let defaultTheme = ThemeManager.currentThemeJson
        
        if defaultTheme == "DefaultTheme" {
            ThemeManager.switchTheme(theme: "RedTheme")
        } else {
            ThemeManager.switchTheme(theme: "DefaultTheme")
        }
        setSwitchState()
    }
    
    @IBAction func dayAndNight(_ sender: Any) {
        let defaultTheme = ThemeManager.currentThemeJson
        
        if defaultTheme != "NightTheme" {
            ThemeManager.switchTheme(theme: "NightTheme")
        } else {
            ThemeManager.switchTheme(theme: "DefaultTheme")
        }
        setSwitchState()
    }
    
    private func setSwitchState() {
        let defaultTheme = ThemeManager.currentThemeJson
        
        if defaultTheme == "NightTheme" {
            dayNightSwitch.setOn(true, animated: false)
        } else {
            dayNightSwitch.setOn(false, animated: false)
        }
    }
}
