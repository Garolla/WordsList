//
//  DBManager.swift
//  CanGatewayApp
//
//  Created by Emanuele Garolla on 02/01/18.
//  Copyright © 2018 Emanuele Garolla. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class WordRealmObj: Object {
    @objc dynamic var word = ""
    @objc dynamic var meaning = ""
    @objc dynamic var count = 0
    @objc dynamic var date = NSDate()
    
    //    override static func primaryKey() -> String? {
    //        return "word"
    //    }
}


class DBManager {
    
    static let shared = DBManager()
    
    private(set) var words : Variable<[Word]> = Variable([Word]())
    
    let realm : Realm
    var objects: Results<WordRealmObj> 
    
    private init() {
        realm = try! Realm()
        objects = try! Realm().objects(WordRealmObj.self).sorted(byKeyPath: "date", ascending: false)
        updateWords()
    }
    
    func updateWords() {
        //        objects = try! Realm().objects(WordRealmObj.self).sorted(byKeyPath: "date")
        var res = [Word] ()
        for o in objects {
            res.append(Word(word: o.word, meaning: o.meaning, count: o.count))
        }
        words.value = res
    }
    
    func updateCountOrCreate(word w: Word) {
        if let wordToEdit = objects.filter("word == '\(w.word)'").first {
            try! realm.write {
                wordToEdit.count = wordToEdit.count + 1
            }
        } else  {
            realm.beginWrite()
            realm.create(WordRealmObj.self, value: [w.word.lowercased(), w.meaning.lowercased(), w.count])
            try! realm.commitWrite()
        }
        
        updateWords()
    }
    
    func delete(word w: Word) {
        if let wordToDelete = objects.filter("word == '\(w.word)'").first {
            realm.beginWrite()
            realm.delete(wordToDelete)
            try! realm.commitWrite()
        }
        updateWords()
    }
    
    func edit(word w: Word) {
        if let wordToEdit = objects.filter("word == '\(w.word)'").first {
            try! realm.write {
                wordToEdit.word = w.word
                wordToEdit.meaning = w.meaning
                wordToEdit.count = w.count
                wordToEdit.date = NSDate()
            }
        }
        updateWords()
    }
    
}
