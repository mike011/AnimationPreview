//
//  TransitionAnimationViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-11.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!

        containerView.addSubview(toView)
        toView.alpha = 0.0
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}

class TransitionAnimationViewController: UIViewController {

    let transition = PopAnimator()

    @IBAction func fadeInButtonPressed(_ sender: Any) {
        guard let fadeInVC = self.storyboard?.instantiateViewController(withIdentifier: "fadeInVC") else {
            return
        }
        fadeInVC.transitioningDelegate = self
        present(fadeInVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TransitionAnimationViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
