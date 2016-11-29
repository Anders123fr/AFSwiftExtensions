//
//  Viewport.swift
//  OpenHouse
//
//  Created by Anders Friis on 08/02/2016.
//  Copyright © 2016 Danske Bank. All rights reserved.
//

import CoreLocation

/*
* Class representing a Viewport which is a square area defined by the top left most point and the bottom right most point.
* Can be used to set the viewport on a MapView.
* Implements NSCoding for persistence in NSUserDefaults
*/
public class Viewport : NSObject, NSCoding {
	var topLeft: CLLocationCoordinate2D
	var bottomRight: CLLocationCoordinate2D
	
	
	init(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D) {
		self.topLeft = topLeft
		self.bottomRight = bottomRight
	}
	
	
	// MARK: NSCoding
	
	public required init?(coder decoder: NSCoder) {
		//Error here "missing argument for parameter name in
		let topLeftDic = decoder.decodeObject(forKey: "topLeft") as! [ String : Double ]
		topLeft = CLLocationCoordinate2DMake(topLeftDic["lat"]!, topLeftDic["long"]!)
		
		let bottomRightDic = decoder.decodeObject(forKey: "bottomRight") as! [ String : Double ]
		bottomRight = CLLocationCoordinate2DMake(bottomRightDic["lat"]!, bottomRightDic["long"]!)
		
		super.init()
	}
	
	public func encode(with coder: NSCoder) {
		let topLeft = [ "lat" : self.topLeft.latitude, "long" : self.topLeft.longitude ]
		let bottomRight = [ "lat" : self.bottomRight.latitude, "long" : self.bottomRight.longitude ]
		
		coder.encode(topLeft, forKey: "topLeft")
		coder.encode(bottomRight, forKey: "bottomRight")
	}
}
