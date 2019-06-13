//
//  AppCollectionCell.swift
//  AppStore
//
//  Created by c.c on 2019/6/10.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class AppCollectionCell: ShadowRoundedCell {
    
    var appCollectionView: AppCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit() 
    }
    
    private func commonInit() {
        appCollectionView = AppCollectionView.fromNib()
        appCollectionView.frame = contentView.bounds
        appCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(appCollectionView)
    }
    
   
    
}
