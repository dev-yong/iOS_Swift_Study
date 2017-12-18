//
//  CustomExtension.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 12..
//  Copyright © 2017년 이광용. All rights reserved.
//

import Foundation
import UIKit

//Shake View
extension UIView
{
    func shake(_ value: Double) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-value, value, -value*(2/3), value*(2/3), -value*(1/3), value*(1/3), 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

//String isNilOrEmpty
extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func isNilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}

//Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

