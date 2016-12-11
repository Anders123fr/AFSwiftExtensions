//
//  UIImage.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 11/12/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

public extension UIImage {

	// Compresses the image and converts it to NSData.
	// Presumably uses the same image compression technique as WhatsApp does
	func compressedToJPEG(maxWidth: CGFloat = 1600.0, maxHeight: CGFloat = 1600.0, compressionQuality: CGFloat = 0.5) -> Data {
		// Reducing file size to a 10th
		
		var actualWidth: CGFloat = self.size.width
		var actualHeight: CGFloat = self.size.height
		var imgRatio: CGFloat = actualWidth/actualHeight
		let maxRatio: CGFloat = maxWidth/maxHeight
		var compressionQual = compressionQuality
		
		if actualHeight > maxHeight || actualWidth > maxWidth {
			if imgRatio < maxRatio {
				// adjust width according to maxHeight
				imgRatio = maxHeight / actualHeight
				actualWidth = imgRatio * actualWidth
				actualHeight = maxHeight
			}
			else if imgRatio > maxRatio {
				// adjust height according to maxWidth
				imgRatio = maxWidth / actualWidth
				actualHeight = imgRatio * actualHeight
				actualWidth = maxWidth
			}
			else {
				actualHeight = maxHeight
				actualWidth = maxWidth
				compressionQual = 1.0
			}
		}
		
		let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
		UIGraphicsBeginImageContext(rect.size)
		self.draw(in: rect)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		let imageData = UIImageJPEGRepresentation(img!, compressionQual)
		UIGraphicsEndImageContext()
		
		return imageData!
	}

}
