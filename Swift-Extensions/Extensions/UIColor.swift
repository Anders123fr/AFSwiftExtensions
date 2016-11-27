//
//  UIColor.swift
//

import UIKit

public extension UIColor {

	static func col(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
		return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
	}
	
	
	/**
	Creates and returns a darker color object.
	
	:returns: A UIColor darkened with an amount of 0.2.
	
	:see: darkenColor:
	*/
	public func darkerColor() -> UIColor {
		return darkenColor(0.2)
	}
	
	/**
	Creates and returns a color object with the lightness decreased by the given amount.
	
	:param: amount Float between 0 and 1.
	
	:returns: A darker UIColor.
	*/
	public func darkenColor(_ amount: CGFloat) -> UIColor {
		let amount = min(1, max(0, amount))
		
		return HSL(color: self).darken(amount).toUIColor()
	}

	
}
