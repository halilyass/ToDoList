//
//  Extensions.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func newPresent(_ viewControllerPresent : UIViewController) {
        
        let trasition = CATransition()
        trasition.duration = 0.2
        trasition.type = .push
        trasition.subtype = .fromRight
        self.view.window?.layer.add(trasition, forKey: "Animation")
        present(viewControllerPresent, animated: false,completion: nil)
    }
    
    func CompleteToHomePresent(_ viewControllerPresent : UIViewController) {
        
        let trasition = CATransition()
        trasition.duration = 0.2
        trasition.type = .push
        trasition.subtype = .fromRight
        guard let vc = presentedViewController else { return }
        vc.dismiss(animated: false) {
            self.view.window?.layer.add(trasition, forKey: "Animation2")
            self.present(viewControllerPresent, animated: false,completion: nil)
        }
    }
    
    func newDismiss() {
        
        let trasition = CATransition()
        trasition.duration = 0.2
        trasition.type = .push
        trasition.subtype = .fromLeft
        self.view.window?.layer.add(trasition, forKey: "BackAnimation")
        dismiss(animated: false,completion: nil)
        
    }
}


