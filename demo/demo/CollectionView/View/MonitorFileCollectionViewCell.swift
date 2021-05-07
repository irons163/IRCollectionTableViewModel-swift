//
//  MonitorFileCollectionViewCell.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class MonitorFileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var switchesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func identifier() -> String {
        return String.init(describing: self)
    }
}
