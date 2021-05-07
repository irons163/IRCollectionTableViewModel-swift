//
//  RowBasicModelItem.swift
//  IRCollectionTableViewModel-swift
//
//  Created by Phil on 2020/9/29.
//  Copyright © 2020 Phil. All rights reserved.
//

import AVFoundation
import UIKit

open class RowBasicModelItem: NSObject {
    var rowType: RowType = 0
    open var type: RowType {
        set {
            rowType = newValue
        }
        get {
            return rowType
        }
    }
    public private(set) var title: String?
    public internal(set) var tagRange: NSRange // length default == 1
    
    public init(type: RowType, title: String) {
        self.title = title
        self.tagRange = NSRange.init(location: 0, length: 1)
        super.init()
        self.type = type
    }
    
    public func setTagRangeLength(length: UInt) {
        self.tagRange = NSRange.init(location: self.tagRange.location, length: Int(length))
    }
}
