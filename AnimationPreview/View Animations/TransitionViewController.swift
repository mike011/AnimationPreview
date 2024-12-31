//
//  TransitionViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-04-23.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class TransitionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var bunnyHolderView: UIView!
    @IBOutlet weak var bunnyImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var blurb: TTTAttributedLabel!
    var hasSetToRed = false

    let pickerData = ["flip from left", "flip from right", "curl up", "curl down", "cross dissolve", "flip from top", "flip from bottom"]
    let data: [String: UIView.AnimationOptions] = ["flip from left": .transitionFlipFromLeft,
                                                   "flip from right": .transitionFlipFromRight,
                                                   "curl up": .transitionCurlUp,
                                                   "curl down": .transitionCurlDown,
                                                   "cross dissolve": .transitionCrossDissolve,
                                                   "flip from top": .transitionFlipFromTop,
                                                   "flip from bottom": .transitionFlipFromBottom]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let blurbText = blurb.text {
            let range = (blurbText as! NSString).range(of: "UiView.transitionWithView")
            blurb.addLink(to: URL(string: "https://developer.apple.com/documentation/uikit/uiview/1622574-transitionwithview"), with: range)
            blurb.delegate = self
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    @IBAction func animationButtonPressed(_ sender: Any) {

        let time: TimeInterval = TimeInterval(duration.text ?? "3") ?? 3.0
        if pickerData[pickerView.selectedRow(inComponent: 0)] == "cross dissolve" {
            if hasSetToRed {
                bunnyHolderView.backgroundColor = UIColor.clear
            } else {
                bunnyHolderView.backgroundColor = UIColor.red
            }
            hasSetToRed = !hasSetToRed
        }

        UIView.transition(with: bunnyHolderView, duration: time, options: self.getOptions(), animations: {
            self.bunnyHolderView.addSubview(self.bunnyImageView)
        }, completion: nil)
    }

    func getOptions() -> UIView.AnimationOptions {
        var options = UIView.AnimationOptions()
        let selected = pickerData[pickerView.selectedRow(inComponent: 0)]
        options.insert(data[selected]!)
        return options
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int ) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int ) -> String? {
        return pickerData[row]
    }
}
