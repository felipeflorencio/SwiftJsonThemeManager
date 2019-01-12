// Made with Swift Json Theme Manager Template by Felipe Garcia
//___FILEHEADER___

import SwiftJsonThemeManager

public var custom___VARIABLE_productName___Id: UInt8 = 0

public enum ___VARIABLE_themeType___: String {
    // Add your types here
    case none
}

extension ___VARIABLE_cocoaSubclass___ {

// ATENTION to have your custom key, always need to be unique for each extension
// Tip: Create a file that have all the key's so you have sure neve have duplicated
    @IBInspectable var identifier___VARIABLE_productName___Name: String {
        get {
            return associatedObject(base: self, key: &custom___VARIABLE_productName___Id, initialiser: { () -> NSString in
                return ""
            }) as String
        }
        set {
            associateObject(base: self, key: &custom___VARIABLE_productName___Id, value: newValue as NSString)
        }
    }

    public var view___VARIABLE_themeType___: ___VARIABLE_themeType___ {
        get {
            return ___VARIABLE_themeType___(rawValue: identifier___VARIABLE_productName___Name) ?? .none
        }
        set {
            identifier___VARIABLE_productName___Name = newValue.rawValue
        }
    }
}

extension ___VARIABLE_cocoaSubclass___: ThemedView {
  
    public func applyUIAppearance(with theme: Theme? = nil, avoid thisViews: [Any]? = nil) {
  
        // If is the type UIViewController use this function to register to update
        // any view controller that you use in your project, can be used to any kind
        // of view too, but is recomended to use with UIViewController only
        // ThemeManager.registerForThemeUpdates(self)
        
        // Check if I should not try to apply template to this view
        if let list = thisViews {
            let isMyType = list.compactMap({ $0 as? ___VARIABLE_cocoaSubclass___ })
            if isMyType.first(where: { view in return view.isEqual(self) }) != nil {
                return
            }
        }
        
        let theme = theme ?? ThemeManager.currentTheme

        switch view___VARIABLE_themeType___ {
	        default: break
        }

        // SAMPLE 
        // switch viewType {
        //  case .simpleView:
        //    	backgroundColor = theme.getThemeColor(name: "button.textColor")
	    //  case .simpleViewColored:
	    //      backgroundColor = theme.getThemeColor(name: "titleColor")
	    //  case .notThemed:
	    //      return
	    //  default: break
        //}

        // If your type is UIView use this in order to apply to all subviews
        // self.subviews.forEach {
        //    $0.applyUIAppearance(with: theme, avoid: thisViews)
        // }
        
        // When you want to have a custom implementation only to that class use this
        if let aSelf = self as? CustomTheme { aSelf.customTheme(theme) }
    }
}
