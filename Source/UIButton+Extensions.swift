//
//  UIButton+Extensions.swift
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
import ObjectiveC

var TapBlockKey: UInt8 = 0
var LongPressBlockKey: UInt8 = 0

// a type for our action block closure
public typealias BlockButtonActionBlock = (_ sender: UIButton) -> Void

class ActionBlockWrapper : NSObject {
    var block : BlockButtonActionBlock
    init(block: @escaping BlockButtonActionBlock) {
        self.block = block
    }
}

public extension UIButton {
    
    // Tap
    public func didTap(_ block: @escaping BlockButtonActionBlock) {
        objc_setAssociatedObject(self, &TapBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(block_handleTapAction), for: .touchUpInside)
    }
    
    @objc fileprivate func block_handleTapAction(sender: UIButton) {
        let wrapper = objc_getAssociatedObject(self, &TapBlockKey) as! ActionBlockWrapper
        wrapper.block(sender)
    }
    
    // Long Press
    public func didLongPress(_ block: @escaping BlockButtonActionBlock) {
        objc_setAssociatedObject(self, &LongPressBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(block_handleLongPressAction))
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc fileprivate func block_handleLongPressAction(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let wrapper = objc_getAssociatedObject(self, &LongPressBlockKey) as! ActionBlockWrapper
            wrapper.block(self)
        }
    }
    
}
