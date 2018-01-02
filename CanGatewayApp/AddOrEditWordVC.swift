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
    
    var wordToEdit: Word?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        deleteBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.deleteWord()
        }).disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        if let w = wordToEdit {
            self.title = "Edit word"
            nameTextField.text = w.word.capitalized
            meaningTextField.text = w.meaning.capitalized
            countTextField.text = "\(w.count)"
            deleteBtn.isHidden = false
        } else {
            self.title = "Add word"
            deleteBtn.isHidden = true
        }
        
        rightButtons = [.done(title: "Save", enable: true)]
    }
    
    private func deleteWord() {
        if let w = wordToEdit {
            DBManager.shared.delete(word: w)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func done() { 
        if let word = nameTextField.text, let mean = meaningTextField.text, let count = Int(countTextField.text ?? "0") {
            if word != "" && mean != "" {
                let w = Word(word: word, meaning: mean, count: count)
                //If the word to edit is nil it means I'm creating a new word (or increase count to a previous written word)
                if wordToEdit == nil {
                    DBManager.shared.updateCountOrCreate(word: w)
                } else { //Otherwise I am in editing mode
                    DBManager.shared.edit(word: w)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
