//
//  NumberFormatter.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 28/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

extension NumberFormatter {

	static func readablePrice(_ price: Double) -> String {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.maximumFractionDigits = 0
		formatter.numberStyle = NumberFormatter.Style.decimal
		
		if let str = formatter.string(for: price) {
			return "\(str)"
		}
		return ""
	}

}
