//
//  AddOrEditWordVC.swift
//  CanGatewayApp
//
//  Created by Emanuele Garolla on 02/01/18.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit

class AddOrEditWordVC: MasterVC {

    var wordToEdit: WordRealmObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if wordToEdit != nil {
            self.title = "Edit word"
        } else {
            self.title = "Add word"
        }
        
        rightButtons = [.done(title: "Save", enable: true)]
        
        
    }
    
    override func done() {
        //TODO: Add or edit 
        dismissSelf()
    }
    

}
