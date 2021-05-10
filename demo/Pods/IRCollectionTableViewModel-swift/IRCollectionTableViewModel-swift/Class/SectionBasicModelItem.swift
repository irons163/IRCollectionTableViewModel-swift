//
//  SectionBasicModelItem.swift
//  IRCollectionTableViewModel-swift
//
//  Created by Phil on 2020/9/29.
//  Copyright © 2020 Phil. All rights reserved.
//

import Foundation
import UIKit

open class SectionBasicModelItem: NSObject, SectionModelItem {
    public var hideCells: Bool = false
    public var rows: [RowBasicModelItem] = []
    
    var _rowCount: UInt
    
    public init(rowCount: UInt) {
        _rowCount = rowCount
        super.init()
    }
    
    open func type() -> SectionType {
//        return .NONE
        return 0
    }
    
    open func rowCount() -> NSInteger {
        return NSInteger(self.hideCells ? 0 : _rowCount)
    }
    
    open func sectionTitle() -> String? {
        return nil
    }
    
    open func sectionLeftIcon() -> UIImage? {
        return nil
    }
}
