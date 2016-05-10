//
//  SettingsVC.swift
//  DrawingApp
//
//  Created by Alex Nguyen on 2016-05-09.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    weak var drawingVC : ViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
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
}
