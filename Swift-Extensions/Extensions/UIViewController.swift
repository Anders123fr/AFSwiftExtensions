//
//  UIViewController.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 27/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

public extension UIViewController {

	/// Find and return the UIViewController that is the current viewController visible in the app
	/// - Returns: The current UIViewController
	static func current() -> UIViewController? {
		guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return nil }
		return findBestVC(vc)
	}
	
	// Recursively find the current view controller
	static private func findBestVC(_ vc: UIViewController) -> UIViewController? {
		if let presVC = vc.presentedViewController {
			
			// Return presented view controller
			return findBestVC(presVC)
			
		} else if vc is UISplitViewController {
			if let splitVC = vc as? UISplitViewController,
				splitVC.viewControllers.count > 0 {
				// Return right hand side
				
				return findBestVC(splitVC.viewControllers.last!)
			} else {
				return vc
			}
			
		} else if vc is UINavigationController {
			if let navVC = vc as? UINavigationController,
				navVC.viewControllers.count > 0 {
				if let topVC = navVC.topViewController {
					return findBestVC(topVC)
				}
			} else {
				return vc
			}
			
		} else if vc is UITabBarController,
			let tabVC = vc as? UITabBarController {
			
			if let selVC = tabVC.selectedViewController,
				(tabVC.viewControllers?.count)! > 0 {
				return findBestVC(selVC)
			} else {
				return vc
			}
		}
		
		// Unknown view controller type, return last child view controller
		return vc
	}
	
	// Call on the parent view controller,
	// if there should be no title text in the back bar button,
	// when pushed to a sub view controller
	func removeBackBarButtonTitle() {
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
}
