//
//  ViewController.swift
//  DrawingApp
//
//  Created by Alex Nguyen on 2016-05-09.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true //Removes title bar
    }

}

