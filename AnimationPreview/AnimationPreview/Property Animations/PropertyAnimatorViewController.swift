//
//  PropertyAnimatorViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-11.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class PropertyAnimatorViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pictureImageView.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)
        scale.addAnimations {
            self.pictureImageView.alpha = 1.0
        }
        scale.startAnimation()
    }
}
