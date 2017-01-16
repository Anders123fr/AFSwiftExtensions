//
//  String.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 25/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

public extension String {

	// Get the char at index, as a String
	func getChar(_ index: Int) -> String {
		return "\(self[self.characters.index(self.startIndex, offsetBy: index)])"
	}
	
	// Capitalizes the first character in the string
	func capitalizeSentence() -> String {
		var newStr = self
		newStr.replaceSubrange(newStr.startIndex...newStr.startIndex, with: String(newStr[newStr.startIndex]).capitalized)
		return newStr
	}
	
	// Returns true if it contains the substring regardless of the case
	func containsIgnoringCase(find: String) -> Bool{
		return self.range(of: find, options: .caseInsensitive) != nil
	}
	
	func fixLastChar(_ lastChar: String) -> String {
		// If there is a last char, and the last char is not the correct one then continue
		guard let curLastChar = self.characters.last , String(curLastChar) != lastChar else { return self }
		
		// append the last char at the end
		return self + lastChar
	}
	
	func containsWhiteSpace() -> Bool {
		// check if there's a range for a whitespace
		let range = self.rangeOfCharacter(from: .whitespaces)
		
		// returns false when there's no range for whitespace
		return range != nil
	}
	
	// Returns the length of the string
	var length: Int { return self.characters.count }  // Swift 2.0
	
	func beginsWith (_ str: String) -> Bool {
		if let range = self.range(of: str) {
			return range.lowerBound == self.startIndex
		}
		return false
	}
	
	func endsWith (_ str: String) -> Bool {
		if let range = self.range(of: str) {
			return range.upperBound == self.endIndex
		}
		return false
	}
	
	// Converts a string to lower case with underscore between Caps
	// e.g. facebookUserID -> facebook_user_id
	func toLowerUnderscoreCase() -> String {
		var string = self
		if string.endsWith("ID") {
			string = string.substring(with: string.startIndex ..< string.characters.index(string.endIndex, offsetBy: -2))
			string = "\(string)_id"
		}
		
		var output = ""
		for chr in string.characters {
			let str = String(chr)
			let lowerChar = str.lowercased()
			if lowerChar != str {
				output += "_\(lowerChar)"
			} else {
				output += str;
			}
		}
		return output
	}
	
	/**
	Removes whitespace from both ends of a string
	*/
	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespaces)
	}
	
	mutating func urlEscapeString() {
		if let escapedStr = addingPercentEncoding(str: self) {
			self = escapedStr
		}
	}
	
	func urlEscapedString() -> String? {
		if let escapedStr = addingPercentEncoding(str: self) {
			return escapedStr
		}
		return nil
	}
	
	private func addingPercentEncoding(str: String) -> String? {
		return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
	}
	
	func removeSubstrings(_ subStrings: [String]) -> String {
		var tmpString = self
		for subString in subStrings {
			tmpString = tmpString.replacingOccurrences(of: subString, with: "")
		}
		return tmpString
	}
	
	
	func toURL() -> URL? {
		return URL(string: self)
	}
	
	func toFileURL() -> URL? {
		return URL(fileURLWithPath: self)
	}
	
	func toData() -> Data? {
		return self.data(using: String.Encoding.utf8)
	}
	
	
	// MARK: JSON Serialization
	
	// Converts a string with json, into a serialized JSON object
	func toJSON() -> [String: AnyObject]? {
		guard let data = self.toData() else {
			return nil
		}
		do {
			return try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments]) as? [String: AnyObject]
		} catch {
			return nil
		}
	}
	
	
	// EMAIL VALIDATION METHOD
	func isValidEmail() -> Bool {
		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
	}
	
	
	/// NSAttributedString extension method
	///
	/// - Parameters:
	///   - substring: an optional substring to style only. If nil, it will style the whole string
	///   - font: The font to apply for the attributed string
	///   - textColor: The text color to apply for the attributed string
	///   - lineSpacing: The line spacing to apply
	/// - Returns: Returns the NSAttributedString
	func style(substring: String? = nil, font: UIFont? = nil, textColor: UIColor? = nil, lineSpacing: CGFloat? = nil) -> NSAttributedString {
		// Start with the range of the full string
		var range = (self as NSString).range(of: self)
		
		// If there is a substring specified then get range of that substring to only style that
		if let substringTmp = substring {
			range = (self as NSString).range(of: substringTmp)
		}
		
		let attributedString = NSMutableAttributedString.init(string: self)
		
		if let newFont = font {
			attributedString.addAttribute(NSFontAttributeName, value: newFont, range: range)
		}
		
		if let newTextColor = textColor {
			attributedString.addAttribute(NSForegroundColorAttributeName, value: newTextColor, range: range)
		}
		
		if let newLineSpacing = lineSpacing {
			let paraStyle = NSMutableParagraphStyle()
			paraStyle.lineSpacing = newLineSpacing
			//paraStyle.alignment = self.textAlignment
			attributedString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: range)
		}
		
		return attributedString
	}

}
