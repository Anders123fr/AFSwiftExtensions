//
//  UILabel.swift
//

import UIKit

public extension UILabel {
	
	func autoScaleText() {
		minimumScaleFactor = 0.5
	}

	func hasText() -> Bool {
		if let text = self.text {
			return text.length > 0
		}
		return false
	}
	
}

