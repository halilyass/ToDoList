//
//  UIButtonExt.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func selectedButton() {
        
        self.backgroundColor = #colorLiteral(red: 0.1981131434, green: 0.4450036883, blue: 1, alpha: 1)
    }
    
    func normalButton() {
        
        self.backgroundColor = #colorLiteral(red: 0.009598493576, green: 0.7325665355, blue: 0.9878998399, alpha: 1)
    }
    
}
