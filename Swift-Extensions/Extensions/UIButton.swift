//
//  UIButton.swift
//  BoligBuddy
//
//  Created by Anders Friis on 26/08/15.
//  Copyright (c) 2015 Danske Bank. All rights reserved.
//

import UIKit

extension UIButton {
	
	func autoScaleTitle() {
		titleLabel?.minimumScaleFactor = 0.5
		titleLabel?.numberOfLines = 1
		titleLabel?.adjustsFontSizeToFitWidth = true
		titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
	}
	
	func animateImageChange(_ newImage: UIImage, duration: TimeInterval = 0.7) {
		layer.removeAllAnimations()

		let crossFade = CABasicAnimation(keyPath: "contents")
		crossFade.duration = duration
		crossFade.fromValue = self.imageView?.image?.cgImage
		crossFade.toValue = newImage.cgImage
		crossFade.isRemovedOnCompletion = true
		crossFade.fillMode = kCAFillModeForwards
		imageView?.layer.add(crossFade, forKey: "animateContents")

		//Make sure to add Image normally after so when the animation
		//is done it is set to the new Image
		setImage(newImage, for: UIControlState())
	}
}
