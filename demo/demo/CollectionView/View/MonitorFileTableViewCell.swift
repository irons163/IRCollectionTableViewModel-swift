//
//  MonitorFileTableViewCell.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class MonitorFileTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbael: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var switchesCountLabel: UILabel!
    @IBOutlet weak var clientsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func identifier() -> String {
        return String.init(describing: self)
    }
}
