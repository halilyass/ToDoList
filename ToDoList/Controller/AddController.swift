//
//  AddController.swift
//  ToDoList
//
//  Created by Halil YAŞ on 30.12.2022.
//

import UIKit

class AddController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var targetDescription: UITextView!
    
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var midTermButton: UIButton!
    @IBOutlet weak var shortTermButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    var targetType : TargetType!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetDescription.delegate = self
        
        configureUI()
        configureButtonUI()
        forwardButton.keyboardAnimation()
        
    }
    
    //MARK: - Actions
    
    @IBAction func clickedLongTerm(_ sender: UIButton) {
        targetType = .LongTerm
        configureButtonUI()
        
    }
    
    @IBAction func clickedMidTerm(_ sender: UIButton) {
        targetType = .MidTerm
        configureButtonUI()
    }
    
    @IBAction func clickedShortTerm(_ sender: UIButton) {
        targetType = .ShortTerm
        configureButtonUI()
    }
    
    @IBAction func clickedForward(_ sender: UIButton) {
        
        if targetDescription.text != "" {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "completeVC") as? CompleteController else { return }
            
            vc.putData(description: targetDescription.text, type: targetType)
            vc.modalPresentationStyle = .fullScreen
            presentingViewController?.CompleteToHomePresent(vc)
        }
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        newDismiss()
    }
    
    //MARK: - Helpers
    
    func configureButtonUI() {
        
        longTermButton.normalButton()
        midTermButton.normalButton()
        shortTermButton.normalButton()
        
        switch targetType {
        case .LongTerm : longTermButton.selectedButton()
        case .MidTerm : midTermButton.selectedButton()
        case .ShortTerm : shortTermButton.selectedButton()
        default : longTermButton.normalButton()
            
        }
    }
    
    func configureUI() {
        longTermButton.layer.cornerRadius = 10
        midTermButton.layer.cornerRadius = 10
        shortTermButton.layer.cornerRadius = 10
        forwardButton.layer.cornerRadius = 10
    }
}

//MARK: - UITextViewDelegate

extension AddController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        targetDescription.text = ""
        targetDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
