//
//  UIFont.swift
//

import UIKit

public extension UIFont {

	class func fontAwesome(_ size: CGFloat) -> UIFont {
		return UIFont(name: "FontAwesome", size: size)!
	}
	
	class func printFonts() {
		let fontFamilyNames = UIFont.familyNames
		for familyName in fontFamilyNames {
			print("------------------------------")
			print("Font Family Name = [\(familyName)]")
			let names = UIFont.fontNames(forFamilyName: familyName )
			print("Font Names = [\(names)]")
		}
	}

}
