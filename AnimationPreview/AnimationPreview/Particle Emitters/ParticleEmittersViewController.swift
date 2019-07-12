//
//  ParticleEmittersViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-18.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class ParticleEmittersViewController: UIViewController {

    @IBOutlet weak var birthRateTextField: UITextField!

    @IBOutlet weak var lifetimeTextField: UITextField!
    @IBOutlet weak var lifetimeRangeTextField: UITextField!

    @IBOutlet weak var accelerationXTextField: UITextField!
    @IBOutlet weak var accelerationYTextField: UITextField!

    @IBOutlet weak var emissionLongitudeTextField: UITextField!
    @IBOutlet weak var emissionLattitudeTextField: UITextField!
    @IBOutlet weak var emissionRangeTextField: UITextField!

    @IBOutlet weak var velocityTextField: UITextField!
    @IBOutlet weak var velocityRangeTextField: UITextField!

    @IBOutlet weak var colourRangeRedTextField: UITextField!
    @IBOutlet weak var colourRangeGreenTextField: UITextField!
    @IBOutlet weak var colourRangeBlueTextField: UITextField!

    @IBOutlet weak var scaleTextField: UITextField!
    @IBOutlet weak var scaleRangeTextField: UITextField!
    @IBOutlet weak var scaleSpeedTextField: UITextField!

    @IBOutlet weak var alphaRangeTextField: UITextField!
    @IBOutlet weak var alphaSpeedTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        set(birthRateTextField, to: 20)
        set(lifetimeTextField, to: 3.5)
        set(lifetimeRangeTextField, to: 1.0)

        set(accelerationYTextField, to: 70.0)
        set(accelerationXTextField, to: 10.0)

        set(velocityTextField, to: 20.0)
        set(velocityRangeTextField, to: 200.0)

        set(emissionLongitudeTextField, to: -.pi)
        set(emissionLattitudeTextField, to: .pi * -0.5)
        set(emissionRangeTextField, to: .pi * 0.5)

        set(colourRangeRedTextField, to: 0.1)
        set(colourRangeGreenTextField, to: 0.1)
        set(colourRangeBlueTextField, to: 0.1)

        set(scaleTextField, to: 0.8)
        set(scaleRangeTextField, to: 0.8)
        set(scaleSpeedTextField, to: -0.15)

        set(alphaRangeTextField, to: 0.75)
        set(alphaSpeedTextField, to: -0.15)
    }

    @IBAction func updateButtonPressed(_ sender: Any) {
        view.layer.removeAllAnimations()
        animate()
    }

    func animate() {

        let rect = CGRect(x: 0.0, y: 75.0, width: view.bounds.width, height: 50.0)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
        emitter.emitterPosition = CGPoint(x: rect.width/2,
                                          y: rect.height/2)
        emitter.emitterSize = rect.size
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "fire")?.cgImage

        emitterCell.birthRate = getFloat(for: birthRateTextField)

        emitterCell.lifetime = getFloat(for: lifetimeTextField)
        emitterCell.lifetimeRange = getFloat(for: lifetimeRangeTextField)

        emitterCell.yAcceleration = getCGFloat(for: accelerationYTextField)
        emitterCell.xAcceleration = getCGFloat(for: accelerationXTextField)

        emitterCell.velocity = getCGFloat(for: velocityTextField)
        emitterCell.velocityRange = getCGFloat(for: velocityRangeTextField)

        emitterCell.emissionLongitude = getCGFloat(for: emissionLongitudeTextField)
        emitterCell.emissionLatitude = getCGFloat(for: emissionLattitudeTextField)
        emitterCell.emissionRange = getCGFloat(for: emissionRangeTextField)

        emitterCell.redRange = getFloat(for: colourRangeRedTextField)
        emitterCell.greenRange = getFloat(for: colourRangeGreenTextField)
        emitterCell.blueRange = getFloat(for: colourRangeBlueTextField)

        emitterCell.scale = getCGFloat(for: scaleTextField)
        emitterCell.scaleRange = getCGFloat(for: scaleRangeTextField)
        emitterCell.scaleSpeed = getCGFloat(for: scaleSpeedTextField)

        emitterCell.alphaRange = getFloat(for: alphaRangeTextField)
        emitterCell.alphaSpeed = getFloat(for: alphaSpeedTextField)

        emitter.emitterCells = [emitterCell]
        view.layer.addSublayer(emitter)
    }

    private func getFloat(for textField: UITextField) -> Float {
        let text = textField.text ?? "0.0"
        return Float(text) ?? 0.0
    }

    private func getCGFloat(for textField: UITextField) -> CGFloat {
        let float = getFloat(for: textField)
        return CGFloat(float)
    }

    private func set(_ textField: UITextField, to: Float) {
        textField.text = String(to)
    }
}
