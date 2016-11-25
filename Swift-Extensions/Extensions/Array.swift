//
//  Array.swift
//  doit
//
//  Created by Anders Friis on 01/05/15.
//  Copyright (c) 2015 doit. All rights reserved.
//

import UIKit
import Gloss

// Extension on array - safe get method
extension Array {
		
	// Safely lookup an index that might be out of bounds,
	// returning nil if it does not exist
	func get(_ index: Int) -> Element? {
		if 0 <= index && index < count {
			return self[index]
		} else {
			return nil
		}
	}
	
	
	// Check if a generic array contains the given object,
	// by comparing the objects of the array with the given param.
	func contains<U: Equatable>(_ object: U) -> Bool {
		for (_, objectToCompare) in self.enumerated() {
			if let to = objectToCompare as? U {
				if object == to {
					return true
				}
			}
		}
		return false
	}

	
	// Safely try to remove an object from a generic array,
	// by comparing the objects with the given param.
	// Returns true if the object was removed
	mutating func removeObject<U: Equatable>(_ object: U) -> Bool {
		for (idx, objectToCompare) in self.enumerated() {
			if let to = objectToCompare as? U {
				if object == to {
					self.remove(at: idx)
					return true
				}
			}
		}
		return false
	}
	
	// Shuffles the array
	mutating func shuffle() {
		for i in 0...(count - 1) {
			let j = Int(arc4random_uniform(UInt32(count - i))) + i
			swap(&self[i], &self[j])
		}
	}
}
