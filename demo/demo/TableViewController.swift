//
//  TableViewController.swift
//  demo
//
//  Created by Phil on 2020/9/30.
//  Copyright © 2020 Phil. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: TableViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: TableViewHeaderView.identifier(), bundle: nil), forHeaderFooterViewReuseIdentifier: TableViewHeaderView.identifier())
        viewModel = TableViewViewModel.init(tableView: self.tableView)
        self.tableView.dataSource = viewModel
        viewModel!.update()
    }

// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView: TableViewHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.identifier()) as! TableViewHeaderView
        sectionHeaderView.titleLabel.text = viewModel!.getSectionTitleinSection(section: section)
        switch viewModel!.getSectionTypeinSection(section: section).rawValue {
        case TableViewSectionType.DemoSection.rawValue:
            break
        default:
            break
        }
        return sectionHeaderView
    }
    
// MARK: - IBAction
    @IBAction func backButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
