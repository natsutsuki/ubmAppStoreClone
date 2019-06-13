//
//  AppArticleCell.swift
//  AppStore
//
//  Created by c.c on 2019/6/10.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class AppArticleCell: ShadowRoundedCell {
    
    var appArticleView: AppArticleView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        appArticleView = AppArticleView.fromNib()
        appArticleView.frame = contentView.bounds
        appArticleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(appArticleView)
    }
    
}
