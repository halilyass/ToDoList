//
//  HomeCell.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var yourGoalLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tagetNumber: UILabel!
    
    @IBOutlet weak var completeView: UIView!
    
    
    func configure(entity : Entity) {
        yourGoalLabel.text = entity.targetDescription
        typeLabel.text = entity.targetType
        tagetNumber.text = String(entity.targetNumber)
        
        if entity.targetNumber == entity.targetCompletion {
            completeView.isHidden = false
        } else {
            completeView.isHidden = true
        }
    }
}
