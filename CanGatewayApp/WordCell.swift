//
//  PokeCell.swift
//  Pokedex
//
//  Created by Emanuele Garolla on 29/08/2017.
//  Copyright © 2017 Emanuele Garolla. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var translatedLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    
    var element: Word!
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ e: Word) {
        element = e
        nameLbl.text = " " + e.word.capitalized
        translatedLbl.text = " \(e.meaning.capitalized) "
        valueLbl.text = "\(e.count) "
    }
}
