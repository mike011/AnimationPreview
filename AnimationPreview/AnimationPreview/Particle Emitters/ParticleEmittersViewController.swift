//
//  ParticleEmittersViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-06-18.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class ParticleEmittersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func updateButtonPressed(_ sender: Any) {
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

        emitterCell.birthRate = 20

        emitterCell.lifetime = 3.5
        emitterCell.lifetimeRange = 1.0

        emitterCell.yAcceleration = 70.0
        emitterCell.xAcceleration = 10.0

        emitterCell.velocity = 20.0
        emitterCell.velocityRange = 200.0

        emitterCell.emissionLongitude = -.pi
        emitterCell.emissionLatitude = .pi * -0.5
        emitterCell.emissionRange = .pi * 0.5

        emitterCell.redRange   = 0.1
        emitterCell.greenRange = 0.1
        emitterCell.blueRange  = 0.1

        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8

        emitterCell.scaleSpeed = -0.15

        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15



        emitter.emitterCells = [emitterCell]
        view.layer.addSublayer(emitter)
    }

}
