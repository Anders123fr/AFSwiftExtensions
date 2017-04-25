//
//  NSAttributedString.swift
//  OpenHouse
//
//  Created by Anders Friis on 26/09/2016.
//  Copyright © 2016 Danske Bank. All rights reserved.
//

import UIKit

public struct StringAttributes {
	
	var font: UIFont? = nil
	var textColor: UIColor? = nil
	var lineSpacing: CGFloat? = nil
	var textAlignment: NSTextAlignment? = nil
	var underline: NSUnderlineStyle? = nil
	
}


public extension NSAttributedString {
	
	/// NSAttributedString extension method
	///
	/// - Parameters:
	///   - substring: an optional substring to style only. If nil, it will style the whole string
	///   - font: The font to apply for the attributed string
	///   - textColor: The text color to apply for the attributed string
	///   - lineSpacing: The line spacing to apply
	/// - Returns: Returns the NSAttributedString
	func style(substring: String? = nil, attributes: StringAttributes) -> NSMutableAttributedString {
		let rangeOfSubstring = self.string.range(substring: substring)
		let attributedString = NSMutableAttributedString.init(attributedString: self)
		
		attributedString.setAttributes(range: rangeOfSubstring, attributes: attributes)

		return attributedString
	}
	
}

public extension NSMutableAttributedString {
	
	/// Set the given string attributes on self
	///
	/// - Parameters:
	///   - range: the range of the subtring to change in self
	///   - attributes: the attributes to change for the substring at the given `range`
	func setAttributes(range: NSRange, attributes: StringAttributes) {
		if let newFont = attributes.font {
			addAttribute(NSFontAttributeName, value: newFont, range: range)
		}
		
		if let newTextColor = attributes.textColor {
			addAttribute(NSForegroundColorAttributeName, value: newTextColor, range: range)
		}
		
		if let newLineSpacing = attributes.lineSpacing {
			let textAlignment = attributes.textAlignment ?? NSTextAlignment.center

			let paraStyle = NSMutableParagraphStyle()
			paraStyle.lineSpacing = newLineSpacing
			paraStyle.alignment = textAlignment
			addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: range)
		}
		
		if let underline = attributes.underline {
			addAttribute(NSUnderlineStyleAttributeName, value: underline.rawValue, range: range)
		}
	}

}

public extension String {
	
	/// String extension method
	///
	/// - Parameters:
	///   - substring: an optional substring to style only. If nil, it will style the whole string
	///   - font: The font to apply for the attributed string
	///   - textColor: The text color to apply for the attributed string
	///   - lineSpacing: The line spacing to apply
	/// - Returns: Returns the NSAttributedString
	func style(substring: String? = nil, attributes: StringAttributes) -> NSMutableAttributedString {
		let rangeOfSubstring = range(substring: substring)
		let attributedString = NSMutableAttributedString.init(string: self)
		
		attributedString.setAttributes(range: rangeOfSubstring, attributes: attributes)

		return attributedString
	}
	
		/// Finds the given substring in self and returns an NSRange describing the location and length of the substring in this
	///
	/// - Parameter substring: The substring to find in self
	/// - Returns: The range of the substring
	func range(substring: String? = nil) -> NSRange {
		// Start with the range of the full string
		var range = (self as NSString).range(of: self)
		
		// If there is a substring specified then get range of that substring to only style that
		if let substringTmp = substring {
			range = (self as NSString).range(of: substringTmp)
		}
		
		return range
	}

}
