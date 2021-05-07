//
//  CollectionBrowser.swift
//  demo
//
//  Created by Phil on 2021/2/20.
//  Copyright © 2021 Phil. All rights reserved.
//

import UIKit

class CollectionBrowser: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    enum MonitorBrowserScrollDirection {
        case ScrollDirectionHorizontal
        case ScrollDirectionVertical
    }
    
    @IBOutlet weak var monitorCollectionView: CustomCollectionView!
    //    @IBOutlet weak var monitorCollectionView: CustomCollectionView?
//    @IBOutlet weak var monitorCollectionView: CustomCollectionView?

    public typealias CurrentPageChangedBlock = (_ currentPage: Int) -> ()
    public typealias ItemSelectedBlock = (_ indexPath: IndexPath) -> ()
    public typealias DeleteClickBlock = (_ index: Int) -> ()
    public typealias EditClickBlock = (_ index: Int) -> ()
    
    var monitors: [Monitorable]? {
        didSet {
            viewModel?.monitors = monitors
            viewModel?.update()
        }
    }
    var direction: MonitorBrowserScrollDirection = .ScrollDirectionHorizontal
    var currentPageChangedBlock: CurrentPageChangedBlock?
    var itemSelectedBlock: ItemSelectedBlock?
    var deleteClickBlock: DeleteClickBlock?
    var editClickBlocks: EditClickBlock?
    
    var heightConstraint: NSLayoutConstraint?
    var currentPageIndex: Int = 0
    var viewModel: CollectionBrowserViewModel?
    var shouldInvalidateLayout: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    func setup() {
        let nibName = String(describing: CollectionBrowser.self)
        let views = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        let viewFromNib: UIView = views?.first as! UIView
        viewFromNib.translatesAutoresizingMaskIntoConstraints = false;
        
        self.addSubview(viewFromNib)
        
        let leadingConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let centerXConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerYConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.heightConstraint = NSLayoutConstraint.init(item: viewFromNib, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        centerXConstraint.isActive = true
        centerYConstraint.isActive = true
        self.heightConstraint!.isActive = true
        
        self.initMonitorCollectionView()
        
        self.viewModel = CollectionBrowserViewModel.init(collectionView: self.monitorCollectionView!)
        self.viewModel?.monitors = self.monitors
        self.monitorCollectionView?.dataSource = self.viewModel
        self.viewModel?.update()
        
        self.shouldInvalidateLayout = true
    }
    
    public func gotoImageIndex(imageIndex: Int) {
        self.reloadDataWithCompletion {
            self.monitorCollectionView?.scrollToItem(at: IndexPath.init(item: imageIndex, section: 0), at: .centeredHorizontally, animated: false)
            
            guard let isPagingEnabled =  self.monitorCollectionView?.isPagingEnabled else { return }
            
            if isPagingEnabled {
                self.setCurrentPageIndex(imageIndex)
            }
        }
    }
    
    public func reloadData() {
        self.shouldInvalidateLayout = true
        self.monitorCollectionView?.reloadDataWithCompletion(completionBlock: nil)
    }
    
    public func reloadDataWithCompletion(completionBlock: (() -> ())?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            NSLog("reload completed")
            self.heightConstraint?.constant = 80
            if (completionBlock != nil) {
                completionBlock!()
            }
        })
        NSLog("reloading")
        
        self.monitorCollectionView?.layoutIfNeeded()
        self.layoutIfNeeded()
        self.monitorCollectionView?.reloadData()
        CATransaction.commit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shouldInvalidateLayout {
            self.monitorCollectionView?.collectionViewLayout.invalidateLayout()
            
            shouldInvalidateLayout = false
        }
    }
    
    func initMonitorCollectionView() {
        self.monitorCollectionView?.backgroundColor = .clear
        self.monitorCollectionView?.showsHorizontalScrollIndicator = false
        
        self.monitorCollectionView?.allowsMultipleSelection = true
        (self.monitorCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        self.monitorCollectionView?.isPagingEnabled = false
        (self.monitorCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = UICollectionViewFlowLayout.automaticSize
        (self.monitorCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        DispatchQueue.main.async {
            self.monitorCollectionView?.collectionViewLayout.invalidateLayout()
            self.monitorCollectionView?.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    //#pragma mark - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.itemSelectedBlock != nil) {
            self.itemSelectedBlock!(indexPath)
        }
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
//    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//        if(self.itemSelectedBlock)
//            self.itemSelectedBlock(indexPath);
//        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//    }
//
//    - (void)didClickDeleteButtonInItemIndex:(NSInteger)itemIndex {
//        if(self.deleteClickBlock)
//            self.deleteClickBlock(itemIndex);
//    }
//
//    - (void)didClickEditButtonInItemIndex:(NSInteger)itemIndex {
//        if(self.editClickBlock)
//            self.editClickBlock(itemIndex);
//    }
    
    // mark - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.checkPageChangedByScrollView(scrollView)
    }
    
    func checkPageChangedByScrollView(_ scrollView: UIScrollView) {
        guard let isPagingEnabled =  self.monitorCollectionView?.isPagingEnabled else { return }
        
        if isPagingEnabled {
            let newPageIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
            self.setCurrentPageIndex(newPageIndex)
        }
    }
    
    func setCurrentPageIndex(_ newPageIndex: Int) {
        if currentPageIndex != newPageIndex {
            currentPageIndex = newPageIndex
            if (self.currentPageChangedBlock != nil) {
                self.currentPageChangedBlock!(currentPageIndex)
            }
        }
    }
}
