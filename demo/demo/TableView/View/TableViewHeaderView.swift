//
//  TableViewHeaderView.swift
//  demo
//
//  Created by Phil on 2020/9/30.
//  Copyright © 2020 Phil. All rights reserved.
//

import UIKit

class TableViewHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    class func identifier() -> String {
        return String.init(describing: self)
    }
}
