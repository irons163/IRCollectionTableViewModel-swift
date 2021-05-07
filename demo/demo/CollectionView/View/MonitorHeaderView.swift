//
//  MonitorHeaderView.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class MonitorHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    
    override func prepareForReuse() {
        self.sortButton.isHidden = true
    }
    
    @IBAction func sortButtonClick(_ sender: Any) {
    }
    
    class func identifier() -> String {
        return String.init(describing: self)
    }
}
