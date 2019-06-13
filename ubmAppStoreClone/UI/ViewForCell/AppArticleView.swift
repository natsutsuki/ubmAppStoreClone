//
//  AppArticleView.swift
//  AppStore
//
//  Created by c.c on 2019/6/10.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

class AppArticleView: UIView {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descirptionLabel: UILabel!
    
    @IBOutlet weak var bgImageVIew: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(bgImage: UIImage, bgType: BackgroundType?, title: String, subtitle: String, description: String)
    {
        bgImageVIew.image = bgImage
        subtitleLabel.text = subtitle
        titleLabel.text = title
        descirptionLabel.text = description
    }
    
}
