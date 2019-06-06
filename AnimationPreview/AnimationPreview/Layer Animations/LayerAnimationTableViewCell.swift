//
//  LayerAnimationTableViewCell.swift
//  AnimationPreview
//
//  Created by Michael Charland on 2019-05-31.
//  Copyright © 2019 charland. All rights reserved.
//

import UIKit

class LayerAnimationTableViewCell: UITableViewCell {

    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
