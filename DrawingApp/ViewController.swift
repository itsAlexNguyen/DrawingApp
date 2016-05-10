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
    var red : CGFloat = 0 //Default value
    var blue : CGFloat = 1 //Default value (of blue)
    var green : CGFloat = 0 //Default value
    
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
            //Draw line between the two points
            drawBetweenPoints(lastPoint, secondPoint: point)
            //Reset the last point to the new point.
            lastPoint = point
        }
        //When someone moves a touch
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //Get the point
            let point = touch.locationInView(drawingView)
            //Draw line between the two points
            drawBetweenPoints(lastPoint, secondPoint: point)
            //Reset the last point to the new point.
        }
        //When some releases their finger out of the screen
        buttonsStackView.hidden = false
    }
    func eraseDrawing() {
        self.drawingView.image = nil
    }
    func drawBetweenPoints(firstPoint: CGPoint, secondPoint: CGPoint) {
        //Set the context size
        UIGraphicsBeginImageContext(self.drawingView.frame.size)
        //Grab the context
        let context = UIGraphicsGetCurrentContext()
        //Set the drawing size
        self.drawingView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.drawingView.frame.size.width, height: self.drawingView.frame.size.height))
        //Move content to the last point
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
        //Draw line to the next point
        CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y)
        CGContextSetRGBStrokeColor(context, red, green, blue, 0.8)
        //Set the shape of the line
        CGContextSetLineCap(context, .Round)
        //Set the size of the line
        CGContextSetLineWidth(context, 20)
        //Stroke the path
        CGContextStrokePath(context)
        //Draw context onto image
        self.drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        //End context editing
        UIGraphicsEndImageContext()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "drawingToSettingSegue" {
            let settingVC = segue.destinationViewController as! SettingsVC
            settingVC.drawingVC = self
        }
    }
    @IBAction func blueTapped(sender: AnyObject) {
        //Setting the RGB Values for blue
        red = 0
        blue = 1
        green = 0

    }
    @IBAction func greenTapped(sender: AnyObject) {
        //Setting the RGB Values for green
        red = 0
        blue = 0
        green = 1
    }
    @IBAction func redTapped(sender: AnyObject) {
        //Setting the RGB Values for red
        red = 1
        blue = 0
        green = 0
    }
    @IBAction func yellowTapped(sender: AnyObject) {
        //Setting the RGB values for yellow
        red = 249.0/255.0
        blue = 23.0/255.0
        green = 214.0/255.0
    }
    @IBAction func randomTapped(sender: AnyObject) {
        //Set the RGB values for a random colour
        red = CGFloat(arc4random_uniform(256)) / 255.0
        blue = CGFloat(arc4random_uniform(256)) / 255.0
        green = CGFloat(arc4random_uniform(256)) / 255.0
    }
}

