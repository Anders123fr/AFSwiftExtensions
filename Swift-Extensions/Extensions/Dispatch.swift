

import Foundation

func delay(_ delay:Double, closure:@escaping ()->()) {
	DispatchQueue.main.asyncAfter(
		deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}


func dispatch(_ closure:@escaping ()->()) {
	DispatchQueue.global().async {
		closure()
	}
}


// Perform a block of code asynchronously
func dispatch(_ closure:@escaping ()->(), completion:(()->())?) {
	DispatchQueue.global().async {
		closure()
		
		if completion != nil {
			DispatchQueue.main.sync(execute: {
				completion!()
			})
		}
	}
}

func mainThread(_ closure:@escaping ()->()) {
	DispatchQueue.main.async {
		closure()
	}
}
