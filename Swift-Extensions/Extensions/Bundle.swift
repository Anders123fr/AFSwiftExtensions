//
//  Bundle.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 11/12/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

public extension Bundle {
	
	var releaseVersionNumber: String? {
		return self.infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	var buildVersionNumber: String? {
		return self.infoDictionary?["CFBundleVersion"] as? String
	}
	
}
