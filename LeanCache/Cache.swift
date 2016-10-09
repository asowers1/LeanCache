//
//  Cache.swift
//  LeanCache
//
//  Created by Andrew Sowers on 05/27/2016.
//  Copyright (c) 2016 Andrew Sowers. All rights reserved.
//

import Foundation

open class Cache<T: NSCoding> {
    let memoryCache: NSCache<AnyObject, AnyObject>
    let persistentCache: PersistentCache<T>
    
    let name: String
    
    public init(name: String) {
        self.name = name
        self.memoryCache = {
            let cache = NSCache<AnyObject, AnyObject>()
            cache.name = name
            return cache
        }()
        
        self.persistentCache = PersistentCache<T>(name: "com.LeanCache.\(name).cache")
    }
    
    open func get() -> T? {
        if let object = self.memoryCache.object(forKey: self.name as AnyObject) as? T {
            return object
        } else if let object = self.persistentCache.get(self.name) {
            return object
        } else {
            return nil
        }
    }
    
    open func set(_ object: T) {
        self.memoryCache.setObject(object, forKey: self.name as AnyObject)
        self.persistentCache.set(object, forKey: self.name)
    }
    
    open func clear() {
        self.memoryCache.removeAllObjects()
        self.persistentCache.clear()
    }
}
