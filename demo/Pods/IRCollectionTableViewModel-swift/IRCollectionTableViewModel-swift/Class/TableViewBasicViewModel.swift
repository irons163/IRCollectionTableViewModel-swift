//
//  TableViewBasicViewModel.swift
//  IRCollectionTableViewModel-swift
//
//  Created by Phil on 2020/9/29.
//  Copyright © 2020 Phil. All rights reserved.
//

import UIKit

open class TableViewBasicViewModel: NSObject {
    
    public var items: [SectionModelItem]!
    weak public var owner: UIViewController?
    
    public override init() {
        super.init()
        
        self.items = []
    }
    
// MARK: - Public
    public func getRowTypeWith(type: SectionType, row: NSInteger) -> NSInteger {
        for sectionItem in items {
            if sectionItem.type() == type {
                return sectionItem.rows[row].type
            }
        }
        
        return NSNotFound
    }
    
    public func getSectionTitleinSection(section: NSInteger) -> String? {
        return items[section].sectionTitle()
    }
    
    public func getSectionLeftIconinSection(section: NSInteger) -> UIImage? {
        return items[section].sectionLeftIcon()
    }
    
    public func getSectionTypeinSection(section: NSInteger) -> SectionType {
        return items[section].type()
    }
    
    public func hideRows(hide: Bool, inSection section: NSInteger) {
        items[section].hideCells = hide
    }
    
    public func hiddenRowsinSection(section: NSInteger) -> Bool {
        return items[section].hideCells
    }
    
    public func getIndexSetWithSectionType(sectionType: SectionType) -> NSIndexSet? {
        var section = -1
        for item in items {
            if item.type() == sectionType {
                section += 1
                break
            }
        }
        
        if section < 0 {
            return nil
        }
        return NSIndexSet.init(index: section)
    }
    
    public func getIndexPathWithSectionType(sectionType: SectionType, rowType: RowType) -> NSIndexPath? {
        var section = -1
        for item in items {
            if item.type() == sectionType {
                section += 1
                break
            }
        }
        
        var row = -1
        for item in items {
            for rowObject in item.rows {
                if rowObject.type == rowType {
                    row += 1
                    break
                }
            }
        }
        
        if section < 0 || row < 0 {
            return nil
        }
        return NSIndexPath.init(row: row, section: section)
    }
    
    public func setupRowTag() {
        var rowTag = 0
        for item in items {
            for row in item.rows {
                row.tagRange = NSRange.init(location: rowTag, length: row.tagRange.length)
                rowTag += row.tagRange.length
            }
        }
    }
    
    public func getIndexPathFromRowTag(rowTag: NSInteger) -> NSIndexPath {
        var rowTag = rowTag
        var indexPath = NSIndexPath.init(row: 0, section: 0)
        var section = 0
        for item in items {
            var rowIndex = 0
            for row in item.rows {
                let tagLength = row.tagRange.length
                rowTag -= tagLength
                
                if rowTag + 1 <= 0 {
                    indexPath = NSIndexPath.init(row: rowIndex, section: section)
                    return indexPath
                }
                
                rowIndex += 1
            }
            section += 1
        }
        return indexPath
    }

}

