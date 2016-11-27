//
//  UITableView.swift
//  SwiftExtensions
//
//  Created by Anders Friis on 27/11/2016.
//  Copyright © 2016 cromian. All rights reserved.
//

import UIKit

public extension UITableView {
	
	/*
	Hides separators between empty cells in the table view.
	Reference: http://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
	*/
	func hideEmptyCellSeparators() {
		tableFooterView = UIView(frame: CGRect.zero)
	}
	
}
