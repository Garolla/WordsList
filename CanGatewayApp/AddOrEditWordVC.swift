//
//  AddOrEditWordVC.swift
//  CanGatewayApp
//
//  Created by Emanuele Garolla on 02/01/18.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift

class AddOrEditWordVC: MasterVC {

    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var meaningTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    
    var wordToEdit: WordRealmObj?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        deleteBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.deleteWord()
        }).disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        if wordToEdit != nil {
            self.title = "Edit word"
            deleteBtn.isHidden = false
        } else {
            self.title = "Add word"
            deleteBtn.isHidden = true
        }
        
        rightButtons = [.done(title: "Save", enable: true)]
    }
    
    private func deleteWord() {
        
    }
    
    override func done() {
        //TODO: Add or edit
        if let word = nameTextField.text, let mean = meaningTextField.text, let count = Int(countTextField.text ?? "0") {
            if word != "" && mean != "" {
                
                let w = Word(word: word, meaning: mean, count: count)
                DBManager.shared.updateWordCountOrCreateWord(word: w)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
