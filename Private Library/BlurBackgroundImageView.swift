//
//  CustomBackgroundImageView.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class BlurEffectBackgroundImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func layoutSubviews() {
        initBackgournd()
    }
    
    func initBackgournd()
    {
        self.contentMode = .scaleAspectFill
        self.addBlurEffect()
    }
}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds 
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

