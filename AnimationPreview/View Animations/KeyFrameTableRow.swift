//
//  KeyFrameTableRow.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-05-04.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation
import UIKit

struct KeyFrameRowData {
    var startTime: String
    var duration: String
    var animation: KeyframeViewController.Animation
}

class KeyFrameTableRow: UITableViewCell {
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
}
