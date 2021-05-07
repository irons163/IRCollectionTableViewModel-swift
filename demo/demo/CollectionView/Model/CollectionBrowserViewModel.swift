//
//  CollectionBrowserViewModel.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit
import IRCollectionTableViewModel_swift

enum MonitorBrowserRowType: NSInteger {
    case RowType_Folder
    case RowType_File
}

class CollectionBrowserRowItem: RowBasicModelItem {
    var newType: MonitorBrowserRowType = .RowType_Folder
    override public var type: MonitorBrowserRowType.RawValue {
        set {
            self.newType = MonitorBrowserRowType(rawValue: newValue)!
        }
        get {
            return newType.rawValue
        }
    }
    
    override init(type: RowType, title: String) {
        super.init(type: type, title: title)
    }
}

class CollectionBrowserSectionItem: SectionBasicModelItem {
//    var newType: MonitorBrowserSectionType = .Monitorable
//    override public private(set) var type: MonitorBrowserSectionType.RawValue {
//        set {
//            self.newType = MonitorBrowserSectionType(rawValue: newValue)!
//        }
//        get {
//            return newType.rawValue
//        }
//    }
    
    private var _sectionTitle: String?
    private var _type: MonitorBrowserSectionType = .Monitorable
//    private var _type: SectionType = .NONE
    
//    override init(rowCount: UInt) {
//        super.init(rowCount: rowCount)
//    }
    
    override func sectionTitle() -> String? {
        return self._sectionTitle
    }
    
    open func sectionTitle(_ sectionTitle: String) {
        self._sectionTitle = sectionTitle
    }
    
    override func type() -> SectionType {
        return self._type.rawValue
    }

    open func type(_ type: MonitorBrowserSectionType) {
        self._type = type
    }
//    override func type() -> SectionType {
//        return self._type
//    }
//
//    open func type(_ type: SectionType) {
//        self._type = type
//    }
}

//extension SectionModelItem {
////    var newType: MonitorBrowserSectionType = .Monitorable
////    override public private(set) var type: MonitorBrowserSectionType.RawValue {
////        set {
////            self.newType = MonitorBrowserSectionType(rawValue: newValue)!
////        }
////        get {
////            return newType.rawValue
////        }
////    }
//
//    func type() -> MonitorBrowserSectionType {
//        return .Monitorable
//    }
//}

class CollectionBrowserViewModel: TableViewBasicViewModel, UICollectionViewDataSource {
    
    var monitors: [Monitorable]?
    
    init(collectionView: UICollectionView) {
        super.init()
        
        items = []
        
        collectionView.register(UINib.init(nibName: MonitorFolderCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: MonitorFolderCollectionViewCell.identifier())
        collectionView.register(UINib.init(nibName: MonitorFileCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: MonitorFileCollectionViewCell.identifier())
    }
    
    func update() {
        items.removeAll()
        
        self.setupRows()
    }
    
    func setupRows() {
        var rowItems: [CollectionBrowserRowItem] = []
        for monitorable: Monitorable in self.monitors ?? [Monitorable]() {
            if monitorable is MonitorableFolderClass {
                rowItems.append(CollectionBrowserRowItem.init(type: MonitorBrowserRowType.RowType_Folder.rawValue, title: ""))
            } else if monitorable is MonitorableFileClass {
                rowItems.append(CollectionBrowserRowItem.init(type: MonitorBrowserRowType.RowType_File.rawValue, title: ""))
            }
        }
        
        let inventoryRowItems = rowItems
        let item = CollectionBrowserSectionItem.init(rowCount: UInt(inventoryRowItems.count))
        item.type(.Monitorable)
        item.rows = inventoryRowItems
        items.append(item)
        
        self.setupRowTag()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].rowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: CollectionBrowserSectionItem = items[indexPath.section] as! CollectionBrowserSectionItem
        switch item.type() {
        case MonitorBrowserSectionType.Monitorable.rawValue:
            do {
                let row: CollectionBrowserRowItem = item.rows[indexPath.row] as! CollectionBrowserRowItem
                switch row.type {
                case MonitorBrowserRowType.RowType_Folder.rawValue:
                    do {
                        let cell: MonitorFolderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MonitorFolderCollectionViewCell.identifier(), for: indexPath) as! MonitorFolderCollectionViewCell
                        let folder: MonitorableFolderClass = self.monitors![indexPath.row] as! MonitorableFolderClass
                        cell.titleLabel.text = folder.name
                        cell.itemsCountLabel.text = String.init(format: "%ld", folder.count!)
                        cell.sizeLabel.text = String.init(format:"%f", folder.size!)
                        return cell
                    }
                case MonitorBrowserRowType.RowType_File.rawValue:
                    let cell: MonitorFileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MonitorFileCollectionViewCell.identifier(), for: indexPath) as! MonitorFileCollectionViewCell
                    let file: MonitorableFileClass = self.monitors![indexPath.row] as! MonitorableFileClass
                    cell.titleLabel.text = file.name
                    cell.sizeLabel.text = String.init(format:"%f", file.size!)
                    return cell
                default:
                    break
                }
            }
        default:
            break
        }
        return UICollectionViewCell.init()
    }
}
