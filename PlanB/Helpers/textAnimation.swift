//
//  textAnimation.swift
//  PlanB
//
//  Created by Алексей Трушковский on 02.09.2021.
//

import UIKit

extension UILabel {
    func setText(text: String) {
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push //1.
        self.text = text
        animation.duration = 0.25
        self.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
        
    }
}

extension UIButton {
    func setText(text: String) {
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push //1.
        self.setTitle(text, for: .normal)
        animation.duration = 0.25
        self.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
        
    }
}

extension UITextView {
    func setText(text: String) {
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push //1.
        self.text = text
        animation.duration = 0.25
        self.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
        
    }
}
