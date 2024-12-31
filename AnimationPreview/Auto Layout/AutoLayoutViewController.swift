//
//  AutoLayoutViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-05-14.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class AutoLayoutViewController: UIViewController {

    @IBOutlet weak var sampleImageView: UIImageView!
    @IBOutlet weak var widthOfImageView: NSLayoutConstraint!
    @IBOutlet weak var heightOfImageView: NSLayoutConstraint!
    @IBOutlet weak var xConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var originalWidth: CGFloat = 0.0
    var originalHeight: CGFloat = 0.0
    var originalx: CGFloat = 0.0
    var originaly: CGFloat = 0.0

    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        originalWidth = widthOfImageView.constant
        originalHeight = heightOfImageView.constant
        originalx = xConstraint.constant
        originaly = bottomConstraint.constant
    }
    
    @IBAction func reset(_ sender: Any) {
        widthOfImageView.constant = originalWidth
        heightOfImageView.constant = originalHeight
        xConstraint.constant = originalx
        bottomConstraint.constant = originaly

        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func getFloat(from: UITextField) -> CGFloat {
        guard let value = from.text else {
            return 0.0
        }
        if value == "" {
            return 0.0
        }
        return CGFloat(Float(value)!)
    }

    @IBAction func go(_ sender: Any) {
        widthOfImageView.constant = widthOfImageView.constant + getFloat(from: widthTextField)
        heightOfImageView.constant = heightOfImageView.constant + getFloat(from: heightTextField)
        xConstraint.constant = xConstraint.constant + getFloat(from: xTextField)
        bottomConstraint.constant = bottomConstraint.constant + getFloat(from: yTextField)

        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
