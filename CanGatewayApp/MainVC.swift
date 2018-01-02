//
//  MainVC.swift
//  CanGatewayApp
//
//  Created by Emanuele Garolla on 02/10/17.
//  Copyright © 2017 Emanuele Garolla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: MasterVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var allWords : Variable<[Word]>  = Variable([])
    private var shownWords : Variable<[Word]> = Variable([])
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.returnKeyType = UIReturnKeyType.done
        self.title = "Words List"
        rightButtons = [.add]
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        
        loadData()
        
        allWords.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "SignalCell", cellType: WordCell.self)) { (row, element, cell) in
                
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                if let cell = self?.tableView.cellForRow(at: indexPath) as? WordCell {
                    self?.performSegue(withIdentifier: "AddOrEditWordSegue", sender: cell.element)
                }
            }).disposed(by: disposeBag)
        
        tableView.tableFooterView = UIView()
        
        //Search bar logic
        searchBar
            .rx.text
            .orEmpty // Make it non-optional
            //            .filter { !$0.isEmpty}
            .subscribe(onNext: { [unowned self] query in // Here we will be notified of every new value
                if query == "" {
                    self.allWords.value = DBManager.shared.words.value
                } else {
                    self.allWords.value = DBManager.shared.words.value
                        .filter { $0.word.contains(query.lowercased()) || $0.meaning.contains(query.lowercased()) } //range(of: query.lowercased()) != nil
                }
            })
            .disposed(by: disposeBag)
        
        //Resign keyboard
        searchBar
            .rx
            .searchButtonClicked.subscribe(onNext: { _ in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .willBeginDragging.subscribe(onNext: { _ in
                self.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func add() {
        performSegue(withIdentifier: "AddOrEditWordSegue", sender: nil)
    }
    
    func loadData() {
        //Update allWords when DB data changes
        DBManager.shared.words.asObservable()
            .bind(to: allWords)
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddOrEditWordSegue", let wordToEdit = sender as? Word {
            print("Editing word: \(wordToEdit.word)")
            
            if let vc = segue.destination as? AddOrEditWordVC {
                vc.wordToEdit = wordToEdit
            }
            
        }
    }
    
}

