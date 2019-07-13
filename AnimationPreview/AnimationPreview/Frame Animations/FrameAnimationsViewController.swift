//
//  FrameAnimationsViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-18.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class FrameAnimationsViewController: UIViewController {

    @IBOutlet var bird: UIImageView!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var repeatCountTextField: UITextField!

    var birdFrames = [
        UIImage(named: "bird-1")!,
        UIImage(named: "bird-2")!,
        UIImage(named: "bird-3")!
    ]

    func loadBirdAnimation() {
        bird.animationImages = birdFrames
        bird.animationDuration = getDouble(for: durationTextField)
        bird.animationRepeatCount = getInt(for: repeatCountTextField)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
    }

    func setValues() {
        set(durationTextField, to: 0.33)
        set(repeatCountTextField, to: 3000)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        bird.stopAnimating()
        setValues()
    }

    @IBAction func goButtonPressed(_ sender: Any) {
        loadBirdAnimation()
        bird.startAnimating()
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        bird.stopAnimating()
    }

    private func getDouble(for textField: UITextField) -> Double {
        let text = textField.text ?? "0.0"
        return Double(text) ?? 0.0
    }

    private func getInt(for textField: UITextField) -> Int {
        let text = textField.text ?? "0"
        return Int(text) ?? 0
    }


    private func set(_ textField: UITextField, to: Float) {
        textField.text = String(format: "%.2f", to)
    }
}
