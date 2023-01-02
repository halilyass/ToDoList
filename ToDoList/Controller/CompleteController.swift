//
//  CompleteController.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import UIKit

class CompleteController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var numberLabel: UITextField!
    
    var targetDescription : String!
    var targetType : TargetType!
    
    func putData(description : String, type : TargetType) {
        self.targetDescription = description
        self.targetType = type
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.layer.cornerRadius = 10
        completeButton.keyboardAnimation()

    }
    
    //MARK: - Actions
    
    @IBAction func clickedCompleteButton(_ sender: UIButton) {
        
        if numberLabel.text != "" {
            
            if Int(numberLabel.text!)! > 0 {
                self.save { finished in
                    if finished {
                        dismiss(animated: true,completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        newDismiss()
    }
    
    
    //MARK: - Helpers
    
    func save(completionHandler : (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let target = Entity(context: managedContext)
        
        target.targetDescription = targetDescription
        target.targetType = targetType.rawValue
        target.targetCompletion = Int32(numberLabel.text!)!
        target.targetNumber = Int32(0)
        
        do {
            
            try managedContext.save()
            completionHandler(true)
            
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
}
