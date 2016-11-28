//
//  DateFormatter.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 28/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

extension DateFormatter {
	
	func readableString(_ date: Date, dateStyle: Style = .medium, timeStyle: Style = .full) -> String {
		self.dateStyle = dateStyle
		self.timeStyle = timeStyle
		
		return self.string(from: date)
	}
	
}
