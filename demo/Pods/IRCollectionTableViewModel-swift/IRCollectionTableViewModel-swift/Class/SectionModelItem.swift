//
//  SectionModelItem.swift
//  IRCollectionTableViewModel-swift
//
//  Created by Phil on 2020/9/29.
//  Copyright © 2020 Phil. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionModelItem: NSObjectProtocol {
    var hideCells: Bool { get set }
    var rows: [RowBasicModelItem] { get set }
    
    func type() -> SectionType
    func rowCount() -> NSInteger
    func sectionTitle() -> String?
    func sectionLeftIcon() -> UIImage?
}
