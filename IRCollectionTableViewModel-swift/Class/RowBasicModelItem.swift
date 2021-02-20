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
    open private(set) var type: RowType
    public private(set) var title: String?
    public internal(set) var tagRange: NSRange // length default == 1
    
    public init(type: RowType, title: String) {
        self.type = type
        self.title = title
        self.tagRange = NSRange.init(location: 0, length: 1)
        super.init()
    }
    
    public func setTagRangeLength(length: UInt) {
        self.tagRange = NSRange.init(location: self.tagRange.location, length: Int(length))
    }
}
