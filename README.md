# SwiftJsonThemeManager

[![CI Status](https://img.shields.io/travis/felipeflorencio/SwiftJsonThemeManager.svg?style=flat)](https://travis-ci.org/felipeflorencio/SwiftJsonThemeManager)
[![Version](https://img.shields.io/cocoapods/v/SwiftJsonThemeManager.svg?style=flat)](https://cocoapods.org/pods/SwiftJsonThemeManager)
[![License](https://img.shields.io/cocoapods/l/SwiftJsonThemeManager.svg?style=flat)](https://cocoapods.org/pods/SwiftJsonThemeManager)
[![Platform](https://img.shields.io/cocoapods/p/SwiftJsonThemeManager.svg?style=flat)](https://cocoapods.org/pods/SwiftJsonThemeManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- Swift 4.2 or higher
- iOS 10

## Installation

SwiftJsonThemeManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftJsonThemeManager'
```
## Swift JSON Theme Manager

It's a library that easy let you configure using a JSON structure and extensions, in order to work you need to use / create your own extensions.

One of the advantages of use a JSON file it's to be able first to use on multiple platform, as both will be able to load this JSON file, you backend can implement a generator in order to maybe your design create the configuration and you just download, you can integrate into your CI environment to download this file remotely, you can even create unit test to make sure the values did not changed!

This is how it works:
1 - Install library and initiate;
2 - Adjust and create your json theme;
3 - Create your extension, starting always by `UIViewController`;
4 - Inside your `UIViewController` initiate / apply theme using:

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        applyUIAppearance()
    }
```

## Usage

1. import SwiftJsonThemeManager

2. Initiate your theme library in AppDelegate like this
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Initialize the Swift JSON Theme Manager with the default one
    _ = ThemeManager.currentTheme

    return true
}
```

3. Create your `JSON` theme, you need at least one filled named as `DefaultTheme.json`, following this pattern:

In order to work we need at least a `definedStyle` key, like:
```json
{
  "definedStyle": {
    "titleFont": ["normal", "medium"],
    "titleColor": ["#74597F", 1],
    "titleTextColor": ["#D84E6C", 1],
    "textColor": ["#5FD7EF", 1],
    "textStyleNormalLarge": ["normal", "extraLarge"],
    "textStyleNormalLargeColor": ["#ABB1D9", 1],
    "primaryDarkColor": ["#91C6B4", 1],
    "backgroundColor": ["#EF4423", 1]
  }
}
```

You need a text size key `textSizes`:
```json
{
  "textSizes": {
    "extraSmall": 13,
    "small": 16,
    "medium": 20,
    "large": 25,
    "extraLarge": 35
  }
}
```

You need a text style key `textStyles`:
```json
{
  "textStyles": {
      "normal": "SourceSansPro-Regular",
      "bold": "SourceSansPro-Semibold",
      "italic": "SourceSansPro-It",
      "boldItalic": "SourceSansPro-SemiboldIt",
      "custom": "plasmatic"
  }
}
```
And the last one is `imageStyle`:
```json
{
  "imageStyle": {
      "touchIDImage": "TouchID",
      "faceIDImage": "FaceID",
      "horse": "horse"
  }
}
```

These are the minimum requirements, remember, the values inside the dictionary it's just for example, the only thing that you base `DefaultTheme` file need is this keys, like this:

```json
{
  "definedStyle": {
    "titleFont": ["normal", "medium"],
    "textColor": ["#5FD7EF", 1],
    "textStyleNormalLarge": ["custom", "large"]
  },
  "textSizes": {
    "medium": 20,
    "large": 25
  },
  "textStyles": {
      "normal": "SourceSansPro-Regular",
      "custom": "plasmatic"
  },
  "imageStyle": {
      "touchIDImage": "TouchID"
  }
}
```
This is a example on how to create your basic JSON file.

4. To use and apply your theme, it's easy, you can use direct inside your code and set the value to the variable like:

```swift
  let theme = ThemeManager.currentTheme
  self.myLabel.font = theme.getThemedFont(name: "titleFont")
  self.myLabel.textColor = themeManager.getThemeColor(name: "textColor")
```

Or you can create the way that is suppose, that is using extension making use of color pattern to use inside your project. And for this I created a template for your Xcode, that you can easy create from Xcode panel using this, to install the template you can easy use the python script, type this command inside your terminal, you need to be in the same folder as the python file are:
```python
  python SetupThemeExtension.py
```

5. If success you just need open Xcode -> New -> File... -> Go to bottom and you will see 'Theme Extension'.

<img src="https://raw.githubusercontent.com/felipeflorencio/SwiftJsonThemeManager/master/screenshots/1.png" width="500" title="Theme Extension Template">

Here you need to set 3 variables:

1 - Extension Name;
2 - Inherit from, for example, if is your first file should be for UIViewController;
3 - Enum type name, to be easier to manage, we set to create a Enum with the given name, for now put a name that will be used for your Enum type;

<img src="https://raw.githubusercontent.com/felipeflorencio/SwiftJsonThemeManager/master/screenshots/2.png" width="500" title="Extension properties">

Let's assume that you named:
- Extension Name: UIViewControllerExtension
- Inherit From: UIViewController
- Enum type name: ViewControllerType

You will have a file like this:

```swift
// Made with Swift Json Theme Manager Template by Felipe Garcia
//
//  UIViewControllerExtension.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia.
//  Copyright © 2019 Felipe Florencio Garcia. All rights reserved.
//

import SwiftJsonThemeManager

// This will be your unique Id to your associatedObject, this is important to be unique for each extension
// as the `identifierUIViewControllerExtensionName` var created below is a runtime variable, in order to not
// mix with any other variable / extension, always make sure it's unique
public var customUIViewControllerExtensionId: UInt8 = 0

// Your Enum of type, here you can manage to have / use a type to each kind template that you will use, just
// like our sample project that we use some custom types in order to set the properties that we want to that type
public enum ViewControllerType: String {
    // Add your types here
    case none
}

extension UIViewController {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
// This is the variable that you set to your view controller, or the type of the extension
// that you created, for example, 'UIView', 'UILabel', and so, to have a identifier that we
// can check and according to this set a color, font, or any customization that you want
    @IBInspectable var identifierUIViewControllerExtensionName: String {
        get {
            return associatedObject(base: self, key: &customUIViewControllerExtensionId, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &customUIViewControllerExtensionId, value: newValue as NSString)
        }
    }

// AS the name say, it's the variable name identifier, is the variable that we use to see what is the name that we
// used to identify this specific view controller.
    public var viewViewControllerType: ViewControllerType {
        get {
            return ViewControllerType(rawValue: identifierUIViewControllerExtensionName) ?? .none
        }
        set {
            identifierUIViewControllerExtensionName = newValue.rawValue
        }
    }
}

extension UIViewController: ThemedView {

  // This is the method that need to be called in order to apply the theme
  // WE can set a new THEME that can be specific just to one view if you want
  // If by some reason we want to avoid a specific type we can set the array of
  // itens that we want to avoid, so if match we just return and don't continue
  // trying to apply any theme configuration
    public func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {

        // If is the type UIViewController use this function to register to update any view
        // controller that you use in your project, it's only for UIViewController type
        ThemeManager.registerForThemeUpdates(self)

        // Check if I should not try to apply template to this view
        if let list = thisViews {
            let isMyType = list.compactMap({ $0 as? UIViewController })
            if isMyType.first(where: { view in return view.isEqual(self) }) != nil {
                return
            }
        }

        let theme = theme ?? ThemeManager.currentTheme

        switch viewViewControllerType {
          default: break
        }

        // SAMPLE
        // switch viewType {
        //  case .simpleView:
        //      backgroundColor = theme.getThemeColor(name: "button.textColor")
      //  case .simpleViewColored:
      //      backgroundColor = theme.getThemeColor(name: "titleColor")
      //  case .notThemed:
      //      return
      //  default: break
        //}

        // You can use this in order to apply theme to all subviews, if you create a extension
        // to your UIView for example, this will loop inside all your subview, and can apply
        // a custom theme color configuration that you set, look at our sample project to learn
        // If your type is UIView use this in order to apply to all subviews
        // self.subviews.forEach {
        //    $0.applyUIAppearance(with: theme, avoid: thisViews)
        // }

        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}

```

This is just a model, how you can use, if you want you can check the sample project and you will easy see how can be used.

One of the advantages of have this method called for all your view controller is the possibility to easy change your theme without need to reload the view itself, as for each view controller that you use the applyUIAppearance() we will register the view controller and when we want to update the view layout the only thing that we need is set a new theme, as soon we set the view that is on your screen will be automatically reloaded, look our sample project at our `SecondViewController`.


6. If you created your project to have a pattern, like the sample project, you can easy set your view, view controller, label type from Storyboard because is `@IBInspectable`, or from code using the `associatedObject` variable direct like the example here.

## Author

Felipe Garcia, felipeflorencio@me.com

## License

SwiftJsonThemeManager is available under the MIT license. See the LICENSE file for more info.
