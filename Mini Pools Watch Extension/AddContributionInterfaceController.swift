//
//  AddContributionInterfaceController.swift
//  Mini Pools Watch Extension
//
//  Created by Kaplún, Sebi on 12/24/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import WatchKit
import Foundation

class AddContributionContext : NSObject{
    var pool : PoolModel?
    var users: [PersonModel] = []
    weak var delegate:AddContributionDelegate? = nil
}


class AddContributionInterfaceController: WKInterfaceController {

    @IBOutlet var noteLabel: WKInterfaceLabel!
    @IBOutlet var addNoteButton: WKInterfaceButton!
    @IBOutlet var contributorPicker: WKInterfacePicker!
    @IBOutlet var amountLabel: WKInterfaceLabel!
    weak var delegate : AddContributionDelegate?
    
    var pool : PoolModel?
    var noteLabelText : String?
    var users : [PersonModel] = []
    var selectedContributor = 0
    var amountSelected = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.noteLabel.setHidden(true)
        
        if  let myContext = context as? AddContributionContext {
            delegate = myContext.delegate
            pool = myContext.pool
            users = myContext.users
            
            let pickerItems: [WKPickerItem] = users.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = $0.name
                pickerItem.title = $0.name
                return pickerItem
            }
            contributorPicker.setItems(pickerItems)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func pickerChanged(_ value: Int) {
       // itemLabel.setText(users[value].name)
        selectedContributor = value
    }
    
    @IBAction func addNote() {
        
        presentTextInputController(withSuggestions: ["Happy birthday!", "Congratulations", "Mazal tov!"], allowedInputMode: .allowAnimatedEmoji) { (results) in
            if let results = results, results.count > 0 {
                let text = results[0] as! String
                self.noteLabel.setText(text)
                self.noteLabelText = text
                self.noteLabel.setHidden(false)
                self.addNoteButton.setHidden(true)
            }
        }
    }
    
    @IBAction func increase() {
       amountSelected += 1
       amountLabel.setText("\(amountSelected)")
    }
    
    
    @IBAction func decrease() {
        if amountSelected > 0 {
            amountSelected -= 1
            amountLabel.setText("\(amountSelected)")
        }
    }
 
    @IBAction func saveContribution() {
        if let poolId = pool?.id, let noteText = noteLabelText {
            let contributor = users[selectedContributor]
                self.delegate?.addContribution(poolId: poolId, contributor: contributor, note: noteText, amount: amountSelected)
                pop()
        }
    }
}
