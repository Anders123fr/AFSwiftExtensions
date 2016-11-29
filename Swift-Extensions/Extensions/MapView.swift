//
//  MapView.swift
//  OpenHouse
//
//  Created by Anders Friis on 08/02/2016.
//  Copyright © 2016 Danske Bank. All rights reserved.
//

import MapKit

public extension MKMapView {

	// Optional completionBlock for getting a callback when the region animation has finished
	func setViewport(_ viewport: Viewport, animated: Bool = true, duration: TimeInterval = 0.7, regionExtraPadding: Double = 1.1, completionBlock:(()->())? = nil) {
		let topLeft = viewport.topLeft
		let bottomRight = viewport.bottomRight
		
		var region = MKCoordinateRegion()
		region.center.latitude = topLeft.latitude - (topLeft.latitude - bottomRight.latitude) * 0.5
		region.center.longitude = topLeft.longitude + (bottomRight.longitude - topLeft.longitude) * 0.5
		
		region.span.latitudeDelta = fabs(topLeft.latitude - bottomRight.latitude) * regionExtraPadding // Add a little extra space on the sides
		region.span.longitudeDelta = fabs(bottomRight.longitude - topLeft.longitude) * regionExtraPadding // Add a little extra space on the sides

		setRegionOnMap(region: region, animated: animated, duration: duration, completionBlock: completionBlock)
	}

	func setViewportFromCoordinates(_ coordinates: CLLocationCoordinate2D) {
		self.setViewport(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
	}
	
	func setViewport(_ location: CLLocation, radius: CLLocationDistance = 1300, animated: Bool = true, duration: TimeInterval = 0.7, completionBlock:(()->())? = nil) {
		let diameter = radius * 2.0
		let region = MKCoordinateRegionMakeWithDistance(location.coordinate, diameter, diameter)
		setRegionOnMap(region: region, animated: animated, duration: duration, completionBlock: completionBlock)
	}

	func setRegionOnMap(region: MKCoordinateRegion, animated: Bool = true, duration: TimeInterval = 0.7, completionBlock:(()->())? = nil) {
		// If there is completion block then use the mapView animate call to set the region in order to get the callback
		if completionBlock != nil {
			MKMapView.animate(withDuration: duration, animations: {
				self.setRegion(region, animated: animated)
			}) {
				_ in
				completionBlock!()
			}
		} else {
			// else just set the region
			self.setRegion(region, animated: animated)
		}
	}
	
	
	func getCurrentViewport() -> Viewport {
		let topLeft = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
		let bottomRight = CGPoint(x: self.bounds.width, y: self.bounds.height)
		let topLeftCoord = convert(topLeft, toCoordinateFrom: self)
		let bottomRightCoord = convert(bottomRight, toCoordinateFrom: self)
		
		return Viewport(topLeft: topLeftCoord, bottomRight: bottomRightCoord)
	}
}
