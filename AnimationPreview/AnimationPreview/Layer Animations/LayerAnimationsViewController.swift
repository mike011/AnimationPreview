//
//  LayerAnimationsViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-05-23.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

struct AnimationStorage {
    let animation: Animation
    let from: Float
    let to: Float
    let duration: Double

    func toString() -> String {
        return ""
    }
}

enum Animation: String, CaseIterable {
    case Opacity = "opacity"
    case PositionX = "position.x"
    case PositionY = "position.y"
    case Bounds // x,y, width, height
    case Rotate = "transform.rotation"
    case ScaleX = "transform.scale.x"
    case ScaleY = "transform.scale.y"
    case TranslateX = "transform.translation.x"
    case TranslateY = "transform.translation.y"
    case SkewX = "transform.skew.x"
    case SkewY = "transform.skew.y"
    case ProjectX = "transform.project.x"
    case ProjectY = "transform.project.y"
    case BorderColor = "Border Colour" // colour
    case BorderWidth = "Border Width" // width
    case BackgroundColor = "backgroundColor" // colour
    case CornerRadius = "Corner Radius" // value
    case ShadowOffset = "Shadow Offset" // size
    case ShadowOpacity = "Shadow Opacity" // float
    case ShadowPath = "Shadow Path" // CGPath
    case ShadowRadius = "Shadow Radius" // float
}

class LayerAnimationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var bananaView: UIImageView!

    var animations = [AnimationStorage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        let title = Animation.allCases[self.picker.selectedRow(inComponent: 0)]
        let alert = UIAlertController(title: title.rawValue, message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "from"
            textField.textAlignment = .center
        })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "to"
            textField.textAlignment = .center
        })
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "duration"
            textField.textAlignment = .center
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let from = Float((alert.textFields![0] as UITextField).text ?? "0") ?? 0
            let to = Float((alert.textFields![1] as UITextField).text ?? "0") ?? 0
            let duration = Double((alert.textFields![2] as UITextField).text ?? "0") ?? 0
            self.animations.append(AnimationStorage(animation: title, from: from, to: to, duration: duration))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func goButtonPressed(_ sender: Any) {
        for values in animations {
            let animation = CABasicAnimation(keyPath: values.animation.rawValue.lowercased())
            animation.fromValue = values.from
            animation.toValue = values.to
            animation.duration = values.duration
            bananaView.layer.add(animation, forKey: nil)
        }
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        animations.removeAll(keepingCapacity: false)
        tableView.reloadData()
    }
}

// MARK: - Table
extension LayerAnimationsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LayerAnimationTableViewCell") as? LayerAnimationTableViewCell else {
            return UITableViewCell()
        }
        cell.animationLabel.text = "Type"
        cell.fromLabel.text = "From"
        cell.toLabel.text = "To"
        cell.durationLabel.text = "Duration"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LayerAnimationTableViewCell") as? LayerAnimationTableViewCell else {
            return UITableViewCell()
        }
        let current = animations[indexPath.row]
        cell.animationLabel.text = current.animation.rawValue
        cell.fromLabel.text = String(current.from)
        cell.toLabel.text = String(current.to)
        cell.durationLabel.text = String(current.duration)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animations.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - Picker
extension LayerAnimationsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
