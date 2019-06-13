//
//  AppOfTheDayView.swift
//  AppStore
//
//  Created by c.c on 2019/6/9.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class AppOfTheDayView: UIView {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let size = logoImageView.frame.height
        logoImageView.layer.cornerRadius = size / 5.0
        logoImageView.layer.borderColor = UIColor.borderColor.cgColor
        logoImageView.layer.borderWidth = 0.5
        logoImageView.clipsToBounds = true
        
        detailButton.layer.masksToBounds = true
        detailButton.layer.cornerRadius = detailButton.frame.height / 2
    }
    
    func config(bgImage: UIImage, bgType: BackgroundType?, app: AppViewModel) {
        
        bgImageView.image = bgImage
        logoImageView.image = app.iconImage
        
        titleLabel.text = app.name
        subTitleLabel.text = app.tagline
        
        detailButton.setTitle(app.appAccess.description, for: UIControl.State.normal)
    }
    
}
