//
//  AnimationEngine.swift
//  DrawingApp
//
//  Created by Alex Nguyen on 2016-05-09.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import pop

class AnimationEngine {
    class var offScreenBottomPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, -UIScreen.mainScreen().bounds.height)
    }
    let ANIM_DELAY = 0.8
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            originalConstants.append(constraint.constant)
            constraint.constant = AnimationEngine.offScreenBottomPosition.x
        }
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int){
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            var index = 0
            repeat {
                let moveAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnimation.toValue = self.originalConstants[index]
                moveAnimation.springBounciness = 12
                moveAnimation.springSpeed = 12
                if (index > 0) {
                    moveAnimation.dynamicsFriction += 25 + CGFloat(index)
                }
                let constraint = self.constraints[index]
                constraint.pop_addAnimation(moveAnimation, forKey: "moveOnScreen")
                index = index + 1
            } while (index < self.constraints.count)
        }
    }
}
