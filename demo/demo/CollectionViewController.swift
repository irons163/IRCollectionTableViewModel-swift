//
//  CollectionViewController.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var monitorBrowser: CollectionBrowser?
    @IBOutlet weak var recentlyMonitoredView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMonitorBrowser()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadData() {
        
    }
    
    func setupMonitorBrowser() {
        var monitors: [Monitorable] = []
        
        for i in 0..<5 {
            let monitorableFolder = MonitorableFolderClass.init()
            monitorableFolder.name = String.init(i)
            monitorableFolder.size = Float(arc4random_uniform(100) + 1)
            monitorableFolder.count = 1
            monitors.append(monitorableFolder)
        }
        
        for i in 0..<5 {
            let monitorableFolder = MonitorableFileClass.init()
            monitorableFolder.name = String.init(i)
            monitorableFolder.size = Float(arc4random_uniform(10) + 1)
            monitors.append(monitorableFolder)
        }

        self.monitorBrowser?.monitors = monitors
        self.monitorBrowser?.reloadDataWithCompletion(completionBlock: nil)
        if monitors.count > 0 {
            self.recentlyMonitoredView?.isHidden = false
        } else {
            self.recentlyMonitoredView?.isHidden = true
        }
    }
    
    // MARK: - IBAction
    @IBAction func backButtonClick(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - NSNotification
    func didReloadOrgsNotification(notification: NSNotification) {
        self.reloadData()
    }
}
