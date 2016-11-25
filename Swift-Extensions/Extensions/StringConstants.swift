//
//  StringConstants.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 25/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

// A list of localized strings used various places in the app

public extension String {
	var localized: String {
		return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
	}
	
	func localizedWithComment(comment:String) -> String {
		return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
	}
}

let kOK = "OK".localized

let kCancel = "Cancel".localized
let kDelete = "Delete".localized
let kError = "Error".localized
let kSend = "Send".localized
let kAdd = "Add".localized

let kGoToAppStore = "Go to App Store".localized

