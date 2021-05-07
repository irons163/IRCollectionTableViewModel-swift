//
//  CustomCollectionView.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView {

    var reloadDataCompletionBlock: (() -> ())?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.reloadDataCompletionBlock != nil {
            self.reloadDataCompletionBlock!()
            self.reloadDataCompletionBlock = nil
        }
    }
    
    func reloadDataWithCompletion(completionBlock: (() -> ())?) {
        self.reloadDataCompletionBlock = completionBlock
        super.reloadData()
    }
}
