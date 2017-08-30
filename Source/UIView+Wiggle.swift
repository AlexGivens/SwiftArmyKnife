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
    
    fileprivate struct AnimationKey {
        static let Rotation = "rotation"
        static let Bounce = "bounce"
    }
    
    func startWiggle() {
        
        let wiggleBounceY = 2.0
        let wiggleBounceDuration = 0.18
        let wiggleBounceDurationVariance = 0.025
        
        let wiggleRotateAngle = 0.02
        let wiggleRotateDuration = 0.14
        let wiggleRotateDurationVariance = 0.025
        
        guard // If the view is already animating rotation or bounce, return
            let keys = layer.animationKeys(),
            keys.contains(AnimationKey.Rotation) == false,
            keys.contains(AnimationKey.Bounce) == false
        else {
            return
        }
        
        //Create rotation animation
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [-wiggleRotateAngle, wiggleRotateAngle]
        rotationAnimation.autoreverses = true
        rotationAnimation.duration = randomize(interval: wiggleRotateDuration, withVariance: wiggleRotateDurationVariance)
        rotationAnimation.repeatCount = .infinity
        
        //Create bounce animation
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounceAnimation.values = [wiggleBounceY, 0]
        bounceAnimation.autoreverses = true
        bounceAnimation.duration = randomize(interval: wiggleBounceDuration, withVariance: wiggleBounceDurationVariance)
        bounceAnimation.repeatCount = .infinity
        
        //Apply animations to view
        UIView.animate(withDuration: 0) {
            self.layer.add(rotationAnimation, forKey: AnimationKey.Rotation)
            self.layer.add(bounceAnimation, forKey: AnimationKey.Bounce)
            self.transform = .identity
        }
    }
    
    func stopWiggle() {
        layer.removeAnimation(forKey: AnimationKey.Rotation)
        layer.removeAnimation(forKey: AnimationKey.Bounce)
    }
    
    // Utility
    
    fileprivate func randomize(interval: TimeInterval, withVariance variance: Double) -> Double{
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
}
