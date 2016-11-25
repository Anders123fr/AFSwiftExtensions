// The MIT License (MIT)
//
// Copyright (c) 2015 Meng To (meng@designcode.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public func spring(_ duration: TimeInterval, delay: TimeInterval = 0.0, animations: (() -> Void)!) {
    
    UIView.animate(
        withDuration: duration,
        delay: delay,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: [],
        animations: {
        
            animations()
        
        }, completion: { finished in
    })
}

public func springEaseIn(_ duration: TimeInterval, animations: (() -> Void)!) {
    
    UIView.animate(
        withDuration: duration,
        delay: 0,
        options: UIViewAnimationOptions.curveEaseIn,
        animations: {
            
            animations()
            
        }, completion: { finished in
    })
}

public func springEaseOut(_ duration: TimeInterval, delay: TimeInterval = 0.0, animations: (() -> Void)!) {
    
    UIView.animate(
        withDuration: duration,
        delay: delay,
        options: UIViewAnimationOptions.curveEaseOut,
        animations: {
            
            animations()
            
        }, completion: { finished in
    })
}

public func springEaseOut(_ duration: TimeInterval, animations: @escaping (()->()), completion: @escaping ()->()) {
	
	UIView.animate(
		withDuration: duration,
		delay: 0,
		options: UIViewAnimationOptions.curveEaseOut,
		animations: {
			
			animations()
			
		}, completion: { _ in
			completion()
	})
}


public func springEaseInOut(_ duration: TimeInterval, delay: TimeInterval = 0, animations: @escaping (()->()), completion: @escaping ()->()) {
    
    UIView.animate(
        withDuration: duration,
        delay: delay,
        options: UIViewAnimationOptions(),
        animations: {
			animations()
		}, completion: { _ in
			completion()
    })
}

public func springLinear(_ duration: TimeInterval, animations: (() -> Void)!) {
    
    UIView.animate(
        withDuration: duration,
        delay: 0,
        options: UIViewAnimationOptions.curveLinear,
        animations: {
            
            animations()
            
        }, completion: { finished in
    })
}


public func springGrowShrink(_ view: UIView, scale: CGFloat = 1.3) {
	UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions(), animations: {
			view.transform = CGAffineTransform(scaleX: scale,y: scale)
		}, completion: { finished in
			UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions(), animations: {
					view.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
				}, completion: { finished in
			})
	})
}


public func springWithDelay(_ duration: TimeInterval, delay: TimeInterval, animations: (() -> Void)!) {
    UIView.animate(
        withDuration: duration,
        delay: delay,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: [],
        animations: {
            
            animations()
            
        }, completion: { finished in
    })
}

public func springWithCompletion(_ duration: TimeInterval, animations: (() -> Void)!, completion: ((Bool) -> Void)!) {

    UIView.animate(
        withDuration: duration,
        delay: 0,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 0.7,
        options: [],
        animations: {
        
            animations()
        
        }, completion: { finished in
            completion(true)
    })
}
