//
//  ViewController.swift
//  demo
//
//  Created by Phil on 2020/9/29.
//  Copyright © 2020 Phil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tableviewButtonClick(_ sender: Any) {
        let tableViewController = TableViewController.init()
        tableViewController.modalPresentationStyle = .fullScreen
        self.present(tableViewController, animated: true, completion: nil)
    }
    
    @IBAction func collectionViewButtonClick(_ sender: Any) {
        let collectionViewController = CollectionViewController.init()
        collectionViewController.modalPresentationStyle = .fullScreen
        self.present(collectionViewController, animated: true, completion: nil)
    }
}

