//
//  UIViewController.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 27/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

extension UIViewController {

	// Call on the parent view controller,
	// if there should be no title text in the back bar button,
	// when pushed to a sub view controller
	func removeBackBarButtonTitle() {
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
}
