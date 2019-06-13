//
//  ViewController.swift
//  AppStore
//
//  Created by c.c on 2019/6/10.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardViewData: [CardViewModel] = CustomData().cardTiles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppArticleCell.self, forCellWithReuseIdentifier: "AppArticleCell")
        collectionView.register(AppCollectionCell.self, forCellWithReuseIdentifier: "AppCollectionCell")
        collectionView.register(AppOfTheDayCell.self, forCellWithReuseIdentifier: "AppOfTheDayCell")
    }
    
    /// 当前选中Cell的在window中的位置
    func selectedCellFrameInWindow() -> CGRect {
        let indexPath = collectionView.indexPathsForSelectedItems!.first!
        
        let cell = collectionView.cellForItem(at: indexPath)!
        let frameInWindow = cell.convert(cell.bounds, to: nil)
        
        return frameInWindow
    }
    
    /// 当前选中Cell的图层
    func cloneSelectedCell() -> UIView? {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
        
        let cell = collectionView.cellForItem(at: indexPath)!
        let frameInWindow = cell.convert(cell.bounds, to: nil)
        
        let cardViewModel = cardViewData[indexPath.item]
        let cardType = cardViewModel.viewType
        
        let cloneView = cardType.createCardView()
        cloneView.frame = frameInWindow
        
        cloneView.layer.cornerRadius = 20.0
        cloneView.layer.borderWidth = 1.0
        cloneView.layer.borderColor = UIColor.clear.cgColor
        cloneView.layer.masksToBounds = true
        
        return cloneView
    }
    
    /// 隐藏选中的Cell
    func hideSelectedCell() {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        
        let cell = collectionView.cellForItem(at: indexPath)!
        cell.isHidden = true
    }
    
    /// 取消隐藏选中的Cell
    func unHideSelectedCell() {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        
        let cell = collectionView.cellForItem(at: indexPath)!
        cell.isHidden = false
    }
    
}

// MARK: - 转场动画指挥
extension ViewController: UIViewControllerTransitioningDelegate
{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is ArticleViewController {
            return ArticleViewPresentingTransitioning()
        }
        
        return nil
    }
    
}
