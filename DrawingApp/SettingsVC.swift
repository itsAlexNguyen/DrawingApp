//
//  SettingsVC.swift
//  DrawingApp
//
//  Created by Alex Nguyen on 2016-05-09.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit
import pop

class SettingsVC: UIViewController {
    weak var drawingVC : ViewController? = nil
    @IBOutlet weak var brushSizeSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var demoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillAppear(animated: Bool) {
        brushSizeSlider.value = Float((drawingVC?.brushSize)!)
        opacitySlider.value = Float((drawingVC?.opacity)!)
        adjustDemoView()
    }
    @IBAction func eraseTapped(sender: AnyObject) {
        drawingVC?.eraseDrawing()
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func sharedTapped(sender: AnyObject) {
        if let image = self.drawingVC?.drawingView.image {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    func adjustDemoView() {
        //Reset demo image view
        demoImageView.image = nil
        //Set the context size
        UIGraphicsBeginImageContext(self.demoImageView.frame.size)
        //Grab the context
        let context = UIGraphicsGetCurrentContext()
        //Set the drawing size
        self.demoImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.demoImageView.frame.size.width, height: self.demoImageView.frame.size.height))
        //Move content to the last point
        CGContextMoveToPoint(context, self.demoImageView.frame.size.width/2, self.demoImageView.frame.size.height/2)
        CGContextAddLineToPoint(context, self.demoImageView.frame.size.width/2, self.demoImageView.frame.size.height/2)
        CGContextSetRGBStrokeColor(context, drawingVC!.red, drawingVC!.green, drawingVC!.blue, drawingVC!.opacity)
        //Set the shape of the line
        CGContextSetLineCap(context, .Round)
        //Set the size of the line
        CGContextSetLineWidth(context, (drawingVC?.brushSize)!)
        //Stroke the path
        CGContextStrokePath(context)
        //Draw context onto image
        self.demoImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        //End context editing
        UIGraphicsEndImageContext()
        
    }
    @IBAction func brushSizeChanged(sender: AnyObject) {
        drawingVC?.changeBrushSizeTo(CGFloat(brushSizeSlider.value))
        adjustDemoView()
        
    }
    @IBAction func opacityChanged(sender: AnyObject) {
        drawingVC?.changeOpacityTo(CGFloat(opacitySlider.value))
        adjustDemoView()
    }
}
