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

    @IBOutlet weak var buttonsStackView: UIStackView!
    
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
        buttonsStackView.hidden = true
        //When someone starts a touch
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //When someone moves a touch
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //When some releases their finger out of the screen
        buttonsStackView.hidden = false
    }
}

