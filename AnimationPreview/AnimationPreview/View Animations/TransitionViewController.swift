//
//  TransitionViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-04-23.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var bunnyHolderView: UIView!
    @IBOutlet weak var bunnyImageView: UIImageView!
    @IBOutlet weak var flipFromLeft: UISwitch!
    @IBOutlet weak var flipFromRight: UISwitch!
    @IBOutlet weak var curlUp: UISwitch!
    @IBOutlet weak var curlDown: UISwitch!
    @IBOutlet weak var crossDisolve: UISwitch!
    @IBOutlet weak var flipFromTop: UISwitch!
    @IBOutlet weak var flipFromBottom: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func animationButtonPressed(_ sender: Any) {

        let time: TimeInterval = TimeInterval(duration.text ?? "3") ?? 3.0
        UIView.transition(with: bunnyHolderView, duration: time, options: self.getOptions(), animations: {
            self.bunnyHolderView.addSubview(self.bunnyImageView)
        }, completion: nil)
    }

    func getOptions() -> UIView.AnimationOptions {
        return [.curveEaseOut, .transitionFlipFromBottom]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
