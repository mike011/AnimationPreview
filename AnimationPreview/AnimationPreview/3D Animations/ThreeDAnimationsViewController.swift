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
    
    @IBOutlet weak var xPercentageTextField: UITextField!
    @IBOutlet weak var yPercentageTextField: UITextField!
    @IBOutlet weak var zPercentageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func getPercentage(field: UITextField) -> CGFloat {
        let percentageString = xPercentageTextField.text ?? "0.0"
        return CGFloat(Float(percentageString) ?? 0.0)
    }

    @IBAction func handleGoButtonPressed(_ sender: Any) {
        let x = getPercentage(field: xPercentageTextField)
        let y = getPercentage(field: yPercentageTextField)
        let z = getPercentage(field: zPercentageTextField)

        rotate(xPercentage: x, yPercentage: y, zPercentage: z)
    }


    func rotate(xPercentage: CGFloat, yPercentage: CGFloat, zPercentage: CGFloat) {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000

        let xRotationTransform = CATransform3DRotate(identity, getAngle(percent: xPercentage), 1.0, 0.0, 0.0)
        let yRotationTransform = CATransform3DRotate(identity, getAngle(percent: yPercentage), 0.0, 1.0, 0.0)
        let zRotationTransform = CATransform3DRotate(identity, getAngle(percent: zPercentage), 0.0, 0.0, 1.0)

        let transform = CATransform3DConcat(xRotationTransform, yRotationTransform)
        let transform2 = CATransform3DConcat(transform, zRotationTransform)

        imageView.layer.transform = transform2
    }

    func getAngle(percent: CGFloat) -> CGFloat {
        let remainingPercent = 1.0 - percent
        let angle: CGFloat = remainingPercent * .pi * -0.5
        return angle
    }
}
