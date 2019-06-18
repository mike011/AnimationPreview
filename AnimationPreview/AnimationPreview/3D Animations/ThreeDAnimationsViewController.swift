//
//  ThreeDAnimationsViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-18.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class ThreeDAnimationsViewController: UIViewController {

    @IBOutlet var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        
    }
}
