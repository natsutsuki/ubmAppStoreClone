//
//  AppOfTheDayCell.swift
//  AppStore
//
//  Created by c.c on 2019/6/10.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class AppOfTheDayCell: ShadowRoundedCell {
    
    var appOfTheDayView: AppOfTheDayView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit() 
    }
    
    private func commonInit() {
        appOfTheDayView = AppOfTheDayView.fromNib()
        appOfTheDayView.frame = contentView.bounds
        appOfTheDayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(appOfTheDayView)
    }

}
