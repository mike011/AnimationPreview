//
//  KeyframeViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-04-23.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class KeyframeViewController: UIViewController {

    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var animationPickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exampleView: UIView!
    @IBOutlet weak var goButton: UIButton!

    enum Animation: String, CaseIterable {
        case Title = "Animation"
        case MoveRight = "Move Right"
        case MoveLeft = "Move Left"
        case MoveUp = "Move Up"
        case MoveDown = "Move Down"
        case FadeOut = "Fade out"
        case Rotate = "Rotate"
    }

    var animations = [KeyFrameRowData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        animationPickerView.delegate = self
        animationPickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        animations.append(KeyFrameRowData(startTime: "Start Time", duration: "Duration", animation: .Title))
    }

    @IBAction func addButton(_ sender: Any) {
        let startTime = Double(startTimeTextField.text!) ?? 0.0
        guard startTime >= 0 && startTime <= 1 else {
            let alert = UIAlertController(title: "", message: "Start time has be between 0 and 1", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let duration = Double(durationTextField.text!) ?? 0.0
        guard duration > 0 else {
            let alert = UIAlertController(title: "", message: "Duration has to be greater then zero.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let animation = Animation.allCases[animationPickerView.selectedRow(inComponent: 0)]
        animations.append(KeyFrameRowData(startTime: String(startTime), duration: String(duration), animation: animation))
        goButton.isEnabled = true
        reset()
    }

    @IBAction func resetButton(_ sender: Any) {
        animations.removeAll()
        goButton.isEnabled = false
        reset()
    }

    func reset() {
        tableView.reloadData()
        startTimeTextField.text = ""
        durationTextField.text = ""
        animationPickerView.selectRow(0, inComponent: 0, animated: true)
    }

    @IBAction func goButton(_ sender: Any) {
        UIView.animateKeyframes(withDuration:6, delay: 0.0, animations: {
            for animation in self.animations {
                if animation.startTime != "Start Time" {
                    let startTime = Double(animation.startTime) ?? 0.0
                    let duration = Double(animation.duration) ?? 0.0
                    UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                        if animation.animation == .MoveRight {
                            self.exampleView.center.x += 10
                        } else if animation.animation == .MoveLeft {
                            self.exampleView.center.x -= 10
                        } else if animation.animation == .MoveUp {
                            self.exampleView.center.y -= 10
                        } else if animation.animation == .MoveDown {
                            self.exampleView.center.y += 10
                        }
                    }
                }
            }
        }, completion: nil
        )
    }
}

// MARK: - Table View
extension KeyframeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? KeyFrameTableRow else {
            return UITableViewCell()
        }
        cell.animationLabel.text = animations[indexPath.row].animation.rawValue
        cell.startTimeLabel.text = String(animations[indexPath.row].startTime)
        cell.durationLabel.text = String(animations[indexPath.row].duration)
        return cell
    }
}

// MARK: - Picker
extension KeyframeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Animation.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int ) -> String? {
        return Animation.allCases[row].rawValue
    }
}
