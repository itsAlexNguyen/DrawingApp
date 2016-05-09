//
//  ViewController.swift
//  DrawingApp
//
//  Created by Alex Nguyen on 2016-05-09.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//
/**
 * - FaceBook Pop Animations
 * -
 */
import UIKit

class ViewController: UIViewController {
    
    var lastPoint = CGPoint.zero
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var drawingView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appBecameActive), name: UIApplicationDidBecomeActiveNotification, object: nil) //Fixes the notification center bug
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true //Removes title bar
    }
    
    func appBecameActive(){
        //Fix the notifcation center bug
        buttonsStackView.hidden = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(drawingView)
            self.lastPoint = point
        }
        
        buttonsStackView.hidden = true
        //When someone starts a touch
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //Get the point
            let point = touch.locationInView(drawingView)
            //Set the context size
            UIGraphicsBeginImageContext(self.drawingView.frame.size)
            //Grab the context
            let context = UIGraphicsGetCurrentContext()
            //Set the drawing size
            self.drawingView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.drawingView.frame.size.width, height: self.drawingView.frame.size.height))
            //Move content to the last point
            CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y)
            //Draw line to the next point
            CGContextAddLineToPoint(context, point.x, point.y)
            //Stroke the path
            CGContextStrokePath(context)
            //Draw context onto image
            self.drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
            //End context editing
            UIGraphicsEndImageContext()
            //Reset the last point to the new point.
            lastPoint = point
        }
        //When someone moves a touch
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //When some releases their finger out of the screen
        buttonsStackView.hidden = false
    }
}

