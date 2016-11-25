//
//  Global.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 25/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit
import AVFoundation


// N.B. Enviroment variable 'DEBUG_BUILD' must be set for the current scheme.
// If set, and running the app from XCode with cable, this method will return true
func isDebugBuild() -> Bool {
	let dic = ProcessInfo.processInfo.environment
	if dic["DEBUG_BUILD"] != nil {
		return true
	}
	return false
}


// iCloud
public let iCloudStore = NSUbiquitousKeyValueStore.default()


// Calls the closure synchronized - locked
func synced(_ lock: AnyObject, closure: () -> ()) {
	objc_sync_enter(lock)
	closure()
	objc_sync_exit(lock)
}


// MARK: Find VC method
func findCurrentViewController() -> UIViewController? {
	guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return nil }
	return findBestVC(vc)
}

// Recursively find the current view controller
func findBestVC(_ vc: UIViewController) -> UIViewController? {
	if let presVC = vc.presentedViewController {
		
		// Return presented view controller
		return findBestVC(presVC)
		
	} else if vc is UISplitViewController {
		if let splitVC = vc as? UISplitViewController
			, splitVC.viewControllers.count > 0 {
			// Return right hand side
			
			return findBestVC(splitVC.viewControllers.last!)
		} else {
			return vc
		}
		
	} else if vc is UINavigationController {
		if let navVC = vc as? UINavigationController
			, navVC.viewControllers.count > 0 {
			if let topVC = navVC.topViewController {
				return findBestVC(topVC)
			}
		} else {
			return vc
		}
		
	} else if vc is UITabBarController,
		let tabVC = vc as? UITabBarController {
		
		if let selVC = tabVC.selectedViewController,
			let vcs = tabVC.viewControllers,
			vcs.count > 0 {
			return findBestVC(selVC)
		} else {
			return vc
		}
	}
	
	// Unknown view controller type, return last child view controller
	return vc
}


// Opens a specific URL but only if it can be opened
func openURL(_ url: String, completion: @escaping (Bool) -> ()) {
	guard let link = url.toURL() else { return }
	
	if UIApplication.shared.canOpenURL(link) {
		UIApplication.shared.open(link, options: [:], completionHandler: completion)
	}
	
}
