//
//  TableViewViewModel.swift
//  demo
//
//  Created by Phil on 2020/9/30.
//  Copyright © 2020 Phil. All rights reserved.
//

import UIKit
import IRCollectionTableViewModel_swift

class TableViewRowItem: RowBasicModelItem {
    var newType: ProfileRowType = .RowType_DemoRow
    override public private(set) var type: ProfileRowType.RawValue {
        set {
            self.newType = ProfileRowType(rawValue: newValue)!
        }
        get {
            return newType.rawValue
        }
    }
    
    override init(type: RowType, title: String) {
        super.init(type: type, title: title)
    }
}

class TableViewSectionItem: SectionBasicModelItem {
    private var _sectionTitle: String?
    private var _type: SectionType = .NONE
    
    override init(rowCount: UInt) {
        super.init(rowCount: rowCount)
    }
    
    override func sectionTitle() -> String? {
        return self._sectionTitle
    }
    
    open func sectionTitle(_ sectionTitle: String) {
        self._sectionTitle = sectionTitle
    }
    
    override func type() -> SectionType {
        return self._type
    }
    
    open func type(_ type: SectionType) {
        self._type = type
    }
}

enum ProfileRowType: NSInteger {
    case RowType_DemoRow
}

class TableViewViewModel: TableViewBasicViewModel, UITableViewDataSource, UITextFieldDelegate {
    
    
    var title: NSString?
    var isEditMode: Bool = false
    
    var editedTexts: [NSString] = []

    init(tableView: UITableView) {
        super.init()
        items = []
        
        tableView.register(UINib.init(nibName: TableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: TableViewCell.identifier())
    }
    
    func update() {
        items.removeAll()
        self.setupRows()
    }
    
    func setupRows() {
        var rowItems: [RowBasicModelItem] = []
        rowItems.append(TableViewRowItem.init(type: ProfileRowType.RowType_DemoRow.rawValue, title: "Demo Row"))
        rowItems.append(TableViewRowItem.init(type: ProfileRowType.RowType_DemoRow.rawValue, title: "Demo Row"))
        editedTexts = []
        for _ in rowItems {
            editedTexts.append("")
        }
        
        let item = TableViewSectionItem.init(rowCount: UInt(rowItems.count))
        item.type(SectionType(rawValue: ProfileRowType.RowType_DemoRow.rawValue)!)
        item.sectionTitle("Demo Section")
        item.rows = rowItems
        self.items.append(item)
        
        self.setupRowTag()
    }

// MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        let row = item.rows[indexPath.row]
        
        switch row.type {
        case ProfileRowType.RowType_DemoRow.rawValue:
            do {
                let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier(), for: indexPath) as! TableViewCell
                cell.titleLabel.text = String.init(format: "%@%ld", row.title!, row.tagRange.location)
                cell.editTextField.text = self.editedTexts[indexPath.row] as String
                cell.editTextField.tag = row.tagRange.location
                cell.editTextField.delegate = self
                return cell
            }
        default:
            break
        }
        return UITableViewCell.init()
    }
}
