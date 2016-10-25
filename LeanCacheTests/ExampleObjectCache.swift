//  ExampleObjectCache.swift
//  LeanCache
//
//  Created by Andrew Sowers on 5/29/16.
//  Copyright © 2016 Andrew Sowers. All rights reserved.
//

import LeanCache
import Foundation

class ExampleObjectCoder: NSObject, NSCoding {
    let exampleObject: ExampleObject?
    
    init(exampleObject: ExampleObject) {
        self.exampleObject = exampleObject
    }
    
    required init?(coder: NSCoder) {
        if let name = coder.decodeObject(forKey: "name") as? String,
            let age = coder.decodeObject(forKey: "age") as? Int,
            let favoriteLanguage = coder.decodeObject(forKey: "favorite_language") as? String {
            self.exampleObject = ExampleObject(name: name, age: age, favoriteLanguage: favoriteLanguage)
        } else {
            self.exampleObject = nil
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.exampleObject?.name, forKey: "name")
        coder.encode(self.exampleObject?.age, forKey: "age")
        coder.encode(self.exampleObject?.favoriteLanguage, forKey: "favorite_language")
    }
}

protocol ExampleObjectCollectionCacheType {
    func get() -> [ExampleObject]?
    func set(_ objects: [ExampleObject])
}

protocol ExampleObjectCacheType {
    func get() -> ExampleObject?
    func set(_ object: ExampleObject)
}


//MARK - archive as single instance

class ExampleObjectCache: NSObject, ExampleObjectCacheType {
    let cache: Cache<ExampleObjectCoder>
    
    override init() {
        self.cache = Cache(name: "exampleObject")
    }
    
    func get() -> ExampleObject? {
        return self.cache.get()?.exampleObject
    }
    
    func set(_ object: ExampleObject) {
        let coder = ExampleObjectCoder(exampleObject: object)
        self.cache.set(coder)
    }
}

//MARK - archive a collection of instances

class ExampleObjectCollectionCache: NSObject, ExampleObjectCollectionCacheType {
    let cache: Cache<NSArray>
    
    override init() {
        self.cache = Cache(name: "exampleObjectCollection")
    }
    
    // implement protocol methods
    
    func get() -> [ExampleObject]? {
        if let coders = self.cache.get() as? [ExampleObjectCoder] {
            return coders.flatMap { $0.exampleObject }
        }
        
        return nil
    }
    
    func set(_ objects: [ExampleObject]) {
        let coders = objects.map { ExampleObjectCoder(exampleObject: $0) }
        self.cache.set(coders as NSArray)
    }
    
    func clear() {
        self.cache.clear()
    }
}
