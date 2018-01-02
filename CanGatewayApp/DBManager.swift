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
    
    func updateWordCountOrCreateWord(word w: Word) {
        if let w = objects.filter("word == '\(w.word)'").first {
            try! realm.write {
                w.count = w.count + 1
            }
        } else  {
            realm.beginWrite()
            realm.create(WordRealmObj.self, value: [w.word, w.meaning, w.count])
            try! realm.commitWrite()
        }
        
        
        updateWords()
    }
    
    func deleteWord(atIndex i: Int) {
        realm.beginWrite()
        realm.delete(objects[i])
        try! realm.commitWrite()
        updateWords()
    }
    
    func editWord(atIndex i: Int, word w: String, meaning m: String, count c: Int) {
        realm.beginWrite()
        realm.delete(objects[i])
        try! realm.commitWrite()
    }
    
}
