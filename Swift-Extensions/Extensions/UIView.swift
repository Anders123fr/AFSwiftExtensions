//
//  UIView.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 27/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit


let defaultCornerRadius = CGFloat(4.0)

public extension UIView {

	// Auto Layout helper methods
	func enableAutoLayout() {
		self.translatesAutoresizingMaskIntoConstraints = true
	}
	
	func disableAutoLayout() {
		self.translatesAutoresizingMaskIntoConstraints = false
	}

	
	func findFirstResponder() -> UIView? {
		if self.isFirstResponder {
			return self
		}
		
		for view in subviews {
			if view.isFirstResponder {
				return view
			}
		}
		
		return nil
	}
	
	
	// CORNER RADIUS
	func makeRoundedCorners(_ cornerRadius: CGFloat = defaultCornerRadius) {
		layer.cornerRadius = cornerRadius
		clipsToBounds = true
	}
	
	func makeViewCircular() {
		layer.cornerRadius = frame.size.width / 2;
		clipsToBounds = true
	}
	
	func addCornerRadiusAnimation(_ from: CGFloat, to: CGFloat, duration: CFTimeInterval) {
		let animation = CABasicAnimation(keyPath:"cornerRadius")
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		animation.fromValue = from
		animation.toValue = to
		animation.duration = duration
		self.layer.add(animation, forKey: "cornerRadius")
		self.layer.cornerRadius = to
	}
	
	// Make drop shadow
	func addDropShadow(_ cornerRadius:CGFloat = defaultCornerRadius) {
		layer.shadowPath = nil
		
		layer.masksToBounds = false
		layer.shadowOffset = CGSize(width: 0, height: 0.5)
		layer.shadowRadius = 0
		layer.shadowOpacity = 0.75
		//		layer.shadowColor = UIColor.greenColor().CGColor
		//		layer.shadowColor = self.backgroundColor?.CGColor
		layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: defaultCornerRadius).cgPath
	}
	
	func gradientLayerName() -> String {
		return "GradientLayer"
	}
	
	func removeGradientColor() {
		let layerName = gradientLayerName()
		
		// Remove any existing gradient layer
		if let subLayers = self.layer.sublayers,
			let lay: CAGradientLayer = subLayers.get(0) as? CAGradientLayer
			, lay.name == layerName {
			// remove the old layer
			lay.removeFromSuperlayer()
		}
	}
	
	// Applies a gradient layer the top of the view
	func applyGradientColor(_ color: UIColor, darkenVal: CGFloat = 0.08) {
		let layerName = gradientLayerName()
		var layerFrame = self.frame
		layerFrame.origin = CGPoint(x: 0,y: 0)
		
		removeGradientColor()
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.name = layerName
		gradientLayer.frame = layerFrame
		
		let darkerColor = color.darkenColor(darkenVal)
		gradientLayer.colors = [ color.cgColor , darkerColor.cgColor ]
		
		self.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	
	// Opaque -> transparent (true) or Transparent -> Opaque (false)
	// Top -> bottom (true) or Left -> Right (false)
	// ColorVal -> white is default
	func applyTransparentGradient(_ opaqueToTransparentDirection: Bool, vertical: Bool, colorVal: CGFloat = 255) {
		let layerName = gradientLayerName()
		var layerFrame = self.frame
		layerFrame.origin = CGPoint(x: 0,y: 0)
		
		removeGradientColor()
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.name = layerName
		gradientLayer.frame = layerFrame
		
		let opaqueColor = UIColor.col(r: colorVal, g: colorVal, b: colorVal)
		let transparentColor = UIColor.col(r: colorVal, g: colorVal, b: colorVal, a: 0)
		
		gradientLayer.startPoint = (vertical) ? CGPoint(x: 0, y: 0) : CGPoint(x: 0, y: 0)
		gradientLayer.endPoint = (vertical) ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
		
		gradientLayer.colors = (opaqueToTransparentDirection) ? [ opaqueColor.cgColor , transparentColor.cgColor ] : [ transparentColor.cgColor , opaqueColor.cgColor ]
		
		self.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	func applyGradientMask(_ opaqueToTransparentDirection: Bool, vertical: Bool) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		
		let opaqueColor = UIColor ( red: 0.6667, green: 0.6667, blue: 0.6667, alpha: 1.0 )
		let transparentColor = UIColor.clear
		
		gradientLayer.startPoint = (vertical) ? CGPoint(x: 0, y: 0) : CGPoint(x: 0, y: 0)
		gradientLayer.endPoint = (vertical) ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
		
		gradientLayer.colors = (opaqueToTransparentDirection) ? [ opaqueColor.cgColor , transparentColor.cgColor ] : [ transparentColor.cgColor , opaqueColor.cgColor ]
		
		self.layer.mask = gradientLayer
	}
	
	func views(withTag: Int) -> [UIView?] {
		return subviews.filter { ($0 as UIView).tag == tag } as [UIView]
	}
	
	func activityIndicatorTag() -> Int {
		return 92716
	}
	
	func showActivityIndicator(deltaY: CGFloat = 0) {
		let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
		var center = self.center
		center.y += deltaY
		activityIndicator.center = center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.tag = activityIndicatorTag()
		addSubview(activityIndicator)
		activityIndicator.startAnimating()
	}
	
	func removeActivityIndicatorView() {
		for view in views(withTag: activityIndicatorTag()) {
			if let indicator = view as? UIActivityIndicatorView {
				indicator.removeFromSuperview()
			}
		}
	}
	
	
	// Border
	func makeBorder(_ borderWidth: CGFloat, borderColor: UIColor) {
		self.layer.borderColor = borderColor.cgColor
		self.layer.borderWidth = borderWidth
	}
	
	
	// MARK: UIView animations
	func shakeView() {
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = 0.07
		animation.repeatCount = 4
		animation.autoreverses = true
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
		self.layer.add(animation, forKey: "position")
	}
	
	
	// MARK: Parallax effect
	func addParallaxEffect(_ relativeVal: Int = 30) {
		// Remove existing motion effects
		for effect in self.motionEffects {
			self.removeMotionEffect(effect)
		}
		
		let relativeVal = 30
		
		let verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.tiltAlongVerticalAxis)
		verticalEffect.minimumRelativeValue = -relativeVal
		verticalEffect.maximumRelativeValue = relativeVal
		
		let horizontalEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.tiltAlongHorizontalAxis)
		horizontalEffect.minimumRelativeValue = -relativeVal
		horizontalEffect.maximumRelativeValue = relativeVal
		
		let effectGroup = UIMotionEffectGroup()
		effectGroup.motionEffects = [ horizontalEffect, verticalEffect ]
		
		self.addMotionEffect(effectGroup)
	}

}
