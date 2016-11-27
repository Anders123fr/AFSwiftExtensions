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
		if let escapedStr = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
			self = escapedStr
		}
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
	
	func toNSData() -> Data? {
		return self.data(using: String.Encoding.utf8)
	}
	
	// EMAIL VALIDATION METHOD
	func isValidEmail() -> Bool {
		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
	}
	
}
