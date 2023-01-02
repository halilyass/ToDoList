//
//  UIViewExt.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func keyboardAnimation() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @objc func keyboard(_ nofitication : NSNotification) {
        
        // klavyenin yerini değiştirme süresi
        let time = nofitication.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = nofitication.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let firstKeybardFrame = (nofitication.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let secondKeyboardFrame = (nofitication.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let diffY = secondKeyboardFrame.origin.y - firstKeybardFrame.origin.y
        
        UIView.animateKeyframes(withDuration: time, delay: 0.0,options: .init(rawValue: curve), animations: {
            self.frame.origin.y += diffY
        },completion: nil)
        
    }
    
}
