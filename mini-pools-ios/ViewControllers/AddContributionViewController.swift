//
//  AddContributionViewController.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

class AddContributionViewController: UIViewController {

    var users : [PersonModel] = []
    var poolId : Int?
    weak var delegate : AddContributionDelegate?
    let pickerView = UIPickerView()
    
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        amountField.delegate = self

        pickerTextField.inputView = pickerView
        pickerTextField.text = users[0].name
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismiss(_:)))
        backView.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddContributionViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddContributionViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    }

    @objc func keyboardWillShow(notification: NSNotification) {
            self.view.frame.origin.y = -50
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func contributePressed(_ sender: Any) {
        let note = noteField.text
        if let amountString = amountField.text, amountString.count > 0, let poolId = poolId {
            let amount = Int(amountString)!
            delegate?.addContribution(poolId: poolId,contributor: users[pickerView.selectedRow(inComponent: 0)], note: note, amount: amount)
            
        } else {
            //TODO: show error
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddContributionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = users[row].name
        pickerTextField.resignFirstResponder()
    }
}

extension AddContributionViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count == 0) { return true }
        
        if (textField == amountField) {
            let cs = CharacterSet(charactersIn:"0123456789")
            let filtered = string.components(separatedBy: cs).filter {  !$0.isEmpty }
            let str = filtered.joined(separator: "")
            
            return (string != str)
        }
        
        return true
    }
}
