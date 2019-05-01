//
//  KeyframeViewController.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-04-23.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class KeyframeViewController: UIViewController {

    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var delayTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exampleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButton(_ sender: Any) {
        durationTextField.text = ""
        delayTextField.text = ""
    }

    @IBAction func resetButton(_ sender: Any) {
    }

    @IBAction func goButton(_ sender: Any) {
    }
}

// MARK: - Table View
extension KeyframeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Picker
extension KeyframeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}
