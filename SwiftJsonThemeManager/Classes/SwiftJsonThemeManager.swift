//
//  SwiftJsonThemeManager.swift
//  SwiftJsonThemeManager
//
//  Created by Felipe Florencio Garcia on 26/12/18.
//  Copyright © 2018 Felipe Florencio Garcia. All rights reserved.
//
import Foundation
import UIKit

class SwiftJsonThemeManager {

	var themeFile: String
	var themeData: [String: Any]!
	var variables: [String: Any]!
	var textSizes: [String: Any]!
	var textStyles: [String: Any]!
    var imageStyles: [String: Any]!
	
    @discardableResult
	init(jsonFile fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            preconditionFailure("JSONFile must not be nil")
        }
		themeFile = path
		self.loadBundle()
	}
	
    @discardableResult
    required convenience init() {
        self.init(jsonFile: UserDefaults.CommonKeys.currentTheme)
    }
    
	func loadBundle() {
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: self.themeFile)) else {
            preconditionFailure("Invalid JSON index file, it must contain the complete file path")
        }
        
        guard let data = (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? [String: Any] else {
            preconditionFailure("Invalid JSON data")
        }
		themeData = data
        guard let variableData = themeData["definedStyle"] as? [String: Any] else {
            preconditionFailure("Invalid JSON data - defined")
        }
        variables = variableData
        
        guard let textSizesData = themeData["textSizes"] as? [String: Any] else {
            preconditionFailure("Invalid JSON data - textSizes")
        }
		textSizes = textSizesData
        
        guard let textStylesData = themeData["textStyles"] as? [String: Any] else {
            preconditionFailure("Invalid JSON data - textStyles")
        }
		textStyles = textStylesData
        
        guard let imageStylesData = themeData["imageStyle"] as? [String: Any] else {
            preconditionFailure("Invalid JSON data - imageStyle")
        }
        imageStyles = imageStylesData
	}
	
	func themedFont(_ fontPath: String) -> UIFont {
        var fontData: [String]?
        // IF we are passing a referecen to the block with expecifications
        // of the block configuration that we are looking for
        if let fontNameReference = self.themeData[string: fontPath] {
            fontData = self.variables[arrayString: fontNameReference]
        } else {
            // Add here the scenario where the user set direct to look for the 'defined' itens
            // so we do not have the block reference we just have the common pattern inside 'defined'
            fontData = self.variables[arrayString: fontPath]
        }

        guard let data = fontData, data.count == 2 else {
            preconditionFailure("You must request a valid font path there's no item for this :(")
        }
        guard let fontName = self.textStyles[data[0]] as? String else {
            preconditionFailure("Invalid font string type or name")
        }
        guard let fontSize = self.textSizes[data[1]] as? CGFloat else {
            preconditionFailure("Invalid font string for size or name")
        }
        guard let font = UIFont(name: fontName, size: fontSize) else {
            preconditionFailure("Failed generate UIFont object")
        }
        return font
    }
    
    func themedColor(_ colorPath: String) -> UIColor {
        var colorData: [Any]?
        // IF we are passing a referecen to the block with expecifications
        // of the block configuration that we are looking for
        if let colorNameReference = self.themeData[string: colorPath] {
            colorData = self.variables[array: colorNameReference]
        } else {
            // Add here the scenario where the user set direct to look for the 'defined' itens
            // so we do not have the block reference we just have the common pattern inside 'defined'
            colorData = self.variables[array: colorPath]
        }
        
        guard let data = colorData, data.count == 2 else {
            preconditionFailure("You must request a valid color path there's no item for this :(")
        }
        
        guard let colorHex = colorData?[0] as? String else {
            preconditionFailure("Invalid color string type or name")
        }
        guard let colorAlpha = colorData?[1] as? CGFloat else {
            preconditionFailure("Invalid color string for value or type")
        }
        return UIColor.colorFromHexString(color: colorHex).withAlphaComponent(colorAlpha)
    }

    func themedImage(_ imagePath: String) -> UIImage {
        var imageName: String?
        
        if let imageNameReference = self.themeData[string: imagePath] {
            imageName = self.imageStyles[string: imageNameReference]
        } else {
            imageName = self.imageStyles[string: imagePath]
        }
        
        guard let name = imageName, let image = UIImage(named: name) else {
            preconditionFailure("You must request a valid image path or there's no item for this :(")
        }
        
        return image
    }
    
    func themeData(_ dataPath: String) -> String {
        
        guard let data = themeData[string: dataPath] else {
            preconditionFailure("Invalid data path")
        }
        
        return data
    }
}
