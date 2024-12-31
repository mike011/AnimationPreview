//
//  ViewController.swift
//  SpringAnimation
//
//  Created by Michael Charland on 2019-02-13.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import SafariServices

class SpringViewController: UIViewController {

    @IBOutlet weak var fromValue: UITextField!
    @IBOutlet weak var toValue: UITextField!
    @IBOutlet weak var initialVelocity: UITextField!
    @IBOutlet weak var mass: UITextField!
    @IBOutlet weak var stiffness: UITextField!
    @IBOutlet weak var damping: UITextField!
    @IBOutlet weak var buttonToAnimate: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var blurb: TTTAttributedLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let blurbText = blurb.text {
            let range = (blurbText as! NSString).range(of: "CASpringAnimation")
            blurb.addLink(to: URL(string: "https://developer.apple.com/documentation/quartzcore/caspringanimation"), with: range)
            blurb.delegate = self
        }
        
        var y = buttonToAnimate.layer.position.y
        toValue.text = y.description
        y += 20
        fromValue.text = y.description
    }

    @IBAction func runAnimation(_ sender: Any) {

        let vert = CASpringAnimation(keyPath: "position.y")
        vert.fromValue = fromValue.getCGFloat()
        vert.toValue = toValue.getCGFloat()
        vert.initialVelocity = initialVelocity.getCGFloat()
        vert.mass = mass.getCGFloat()
        vert.stiffness = stiffness.getCGFloat()
        vert.damping = damping.getCGFloat()
        vert.duration = vert.settlingDuration
        vert.delegate = self;
        buttonToAnimate.layer.add(vert, forKey: nil)
        goButton.isEnabled = false

        var durationText = NSString(format: "%.2f", vert.duration) as String
        if vert.duration > 10_000_000 {
            durationText = vert.duration.scientificFormatted
        }
        duration.text = durationText
    }

}

extension SpringViewController: @preconcurrency CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        goButton.isEnabled = true
    }
}

extension UITextField {
    func getCGFloat() -> CGFloat {
        if let text = self.text, let number = NumberFormatter().number(from: text) {
            return CGFloat(truncating: number)
        }
        return 0
    }
}

extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

extension Numeric {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}

// MARK: Hyperlinking
extension UIViewController: @preconcurrency TTTAttributedLabelDelegate, @preconcurrency SFSafariViewControllerDelegate {
    
    public func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        vc.delegate = self

        present(vc, animated: true)
    }

    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
