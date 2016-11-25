//
//  UILabel.swift
//  BoligBuddy
//
//  Created by Anders Friis on 19/08/15.
//  Copyright (c) 2015 Danske Bank. All rights reserved.
//

import UIKit

extension UILabel {
	
	func autoScaleText() {
		minimumScaleFactor = 0.5
	}

	func hasText() -> Bool {
		if let text = self.text {
			return text.length > 0
		}
		return false
	}
	
	func setLineHeight(_ lineSpacing: CGFloat = 6) {
		let paraStyle = NSMutableParagraphStyle()
		paraStyle.lineSpacing = lineSpacing
		paraStyle.alignment = self.textAlignment
		
		let attrString = NSMutableAttributedString(string: self.text!)
		attrString.addAttribute(NSParagraphStyleAttributeName, value:paraStyle, range:NSMakeRange(0, attrString.length))
		
		self.attributedText = attrString
	}
	
}

