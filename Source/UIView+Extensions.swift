//
//  UIView+Extensions.swift
//
//  Copyright (c) 2017 Alex Givens (http://alexgivens.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension UIView {
    
    var isVisible: Bool {
        return self.window != nil && self.alpha > 0.0 && self.isHidden == false
    }
    
    func roundCorners(_ corners: UIRectCorner, forRadius radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    var nestedSubviews: [UIView] {
        var array = [subviews].flatMap {$0}
        array.forEach { array.append(contentsOf: $0.nestedSubviews) }
        return array
    }
    
    func logViewHierarchy(_ counter: Int = 1) {
        print("> \(self)")
        for view in subviews {
            var marker = ""
            for _ in 0...counter {
                marker += "-"
            }
            marker += ">"
            print("\(marker) \(view)")
            view.logViewHierarchy(counter + 1)
        }
    }
    
}
