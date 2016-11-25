//
//  UIAlert.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 25/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit


// GLOBAL ALERT FUNCTIONS

// Shows a standard alert to the user with a title and an optional message.
// The alert then has an OK button
func showAlertInCurrentVC(_ title: String, message: String? = nil) {
	// Create the alert
	let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
	
	// Add the OK button
	alertController.addAction(UIAlertAction(title: kOK, style: UIAlertActionStyle.default) {
		action in
	})
	
	alertController.view.tag = getAlertTag()
	
	// Show alert that the current app version is too low and an update is required
	if let vc = findCurrentViewController() {
		vc.present(alertController, animated: true) {}
	}
}

func getAlertTag() -> Int {
	return 191756
}

func isAlertAlreadyShown() -> Bool {
	if let rv = UIApplication.shared.keyWindow?.subviews.first,
		let _ = rv.viewWithTag(getAlertTag()) {
		return true
	}
	return false
}

